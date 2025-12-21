from fastapi import APIRouter, HTTPException
from app.schemas.requests import StartAssessment, SubmitAnswers, CompleteAssessment
from app.schemas.responses import StartResponse, ResultResponse
from app.database.db import Database
from app.utils.helpers import generate_session_id, generate_task_id
from app.services.gemini import process_assessment_results
import json

router = APIRouter()


@router.post("/start", response_model=StartResponse)
async def start_assessment(request: StartAssessment):
    track = await Database.fetch_one(
        "SELECT id FROM tracks WHERE name = ?", (request.track,)
    )
    if not track:
        raise HTTPException(status_code=400, detail=f"Invalid track: {request.track}")
    
    session_id = generate_session_id()
    await Database.execute(
        "INSERT INTO sessions (session_id, track_id) VALUES (?, ?)",
        (session_id, track['id'])
    )
    
    count_res = await Database.fetch_one(
        "SELECT COUNT(*) as count FROM questions WHERE track_id = ?", (track['id'],)
    )
    
    return StartResponse(session_id=session_id, total_questions=count_res['count'])


@router.post("/submit")
async def submit_answers(request: SubmitAnswers):
    session = await Database.fetch_one(
        "SELECT id FROM sessions WHERE session_id = ?", (request.session_id,)
    )
    if not session:
        raise HTTPException(status_code=404, detail="Session not found")
        
    values = [
        (request.session_id, ans.question_id, ans.selected_option_id)
        for ans in request.answers
    ]
    
    await Database.execute_many(
        "INSERT INTO user_responses (session_id, question_id, selected_option_id) VALUES (?, ?, ?)",
        values
    )
    
    await Database.execute(
        "UPDATE sessions SET status = 'SUBMITTED' WHERE session_id = ?",
        (request.session_id,)
    )
    
    return {"message": "Responses saved successfully"}


@router.post("/complete", response_model=ResultResponse)
async def complete_assessment(request: CompleteAssessment):
    task_id = generate_task_id()
    
    # Process assessment
    await process_assessment_results(request.session_id, task_id)
    
    # Fetch results (removed redundant session check)
    session_data = await Database.fetch_one(
        """
        SELECT s.session_id, t.name as track, s.overall_score, s.recommendation_text, s.status
        FROM sessions s
        JOIN tracks t ON s.track_id = t.id
        WHERE s.session_id = ?
        """,
        (request.session_id,)
    )
    
    if not session_data:
        raise HTTPException(status_code=404, detail="Session not found")
    
    scores = json.loads(session_data['overall_score']) if session_data['overall_score'] else {}
    
    return ResultResponse(
        session_id=session_data['session_id'],
        track=session_data['track'],
        overall_score=scores,
        recommendation_text=session_data['recommendation_text'],
        status=session_data['status']
    )
