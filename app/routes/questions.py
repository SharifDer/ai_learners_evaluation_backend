from fastapi import APIRouter, HTTPException, Query
from app.schemas.responses import PaginatedQuestionsResponse, QuestionResponse, AnswerOptionResponse
from app.database.db import Database

router = APIRouter()

@router.get("", response_model=PaginatedQuestionsResponse)
async def get_questions(
    session_id: str,
    page: int = Query(1, ge=1),
    size: int = Query(10, ge=1, le=50)
):
    session = await Database.fetch_one(
        "SELECT track_id FROM sessions WHERE session_id = ?", (session_id,)
    )
    if not session:
        raise HTTPException(status_code=404, detail="Session not found")
        
    limit = size
    offset = (page - 1) * size
    
    # Get questions for this page
    questions = await Database.fetch_all(
        """
        SELECT id, text, category FROM questions 
        WHERE track_id = ? 
        ORDER BY order_position 
        LIMIT ? OFFSET ?
        """,
        (session['track_id'], limit, offset)
    )
    
    # Get options
    if not questions:
         return PaginatedQuestionsResponse(
            session_id=session_id, page=page, size=size, total=0, questions=[]
        )
        
    q_ids = [q['id'] for q in questions]
    placeholders = ','.join('?' * len(q_ids))
    
    options = await Database.fetch_all(
        f"SELECT id, question_id, option_text FROM answer_options WHERE question_id IN ({placeholders}) ORDER BY order_position",
        tuple(q_ids)
    )
    
    options_map = {}
    for opt in options:
        qid = opt['question_id']
        if qid not in options_map: options_map[qid] = []
        options_map[qid].append(AnswerOptionResponse(id=opt['id'], option_text=opt['option_text']))
        
    # Build response
    final_questions = []
    for q in questions:
        final_questions.append(QuestionResponse(
            id=q['id'],
            text=q['text'],
            category=q['category'],
            options=options_map.get(q['id'], [])
        ))
        
    count = await Database.fetch_one(
        "SELECT COUNT(*) as c FROM questions WHERE track_id = ?", (session['track_id'],)
    )
    
    return PaginatedQuestionsResponse(
        session_id=session_id,
        page=page,
        size=size,
        total=count['c'],
        questions=final_questions
    )
