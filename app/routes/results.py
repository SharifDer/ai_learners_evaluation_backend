from fastapi import APIRouter, HTTPException
from app.schemas.responses import ResultResponse, TaskResponse
from app.services.gemini import TASK_STATUS
from app.database.db import Database
import json

router = APIRouter()

@router.get("/status/{task_id}", response_model=TaskResponse)
async def get_status(task_id: str):
    status = TASK_STATUS.get(task_id)
    if not status:
        raise HTTPException(status_code=404, detail="Task not found")
    return TaskResponse(task_id=task_id, status=status)

@router.get("/{session_id}", response_model=ResultResponse)
async def get_results(session_id: str):
    session = await Database.fetch_one(
        """
        SELECT s.session_id, t.name as track, s.overall_score, s.recommendation_text, s.status
        FROM sessions s
        JOIN tracks t ON s.track_id = t.id
        WHERE s.session_id = ?
        """,
        (session_id,)
    )
    
    if not session:
        raise HTTPException(status_code=404, detail="Session not found")
        
    if session['status'] != 'COMPLETED':
        raise HTTPException(status_code=400, detail="Results not ready")
        
    try:
        scores = json.loads(session['overall_score']) if session['overall_score'] else {}
    except:
        scores = {}
        
    return ResultResponse(
        session_id=session['session_id'],
        track=session['track'],
        overall_score=scores,
        recommendation_text=session['recommendation_text'],
        status=session['status']
    )
