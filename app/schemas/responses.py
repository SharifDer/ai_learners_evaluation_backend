from pydantic import BaseModel
from typing import List, Dict, Optional, Any

class AnswerOptionResponse(BaseModel):
    id: int
    option_text: str

class QuestionResponse(BaseModel):
    id: int
    text: str
    category: str
    options: List[AnswerOptionResponse]

class PaginatedQuestionsResponse(BaseModel):
    session_id: str
    page: int
    size: int
    total: int
    questions: List[QuestionResponse]

class StartResponse(BaseModel):
    session_id: str
    total_questions: int

class TaskResponse(BaseModel):
    task_id: str
    status: str

class ResultResponse(BaseModel):
    session_id: str
    track: str
    overall_score: Dict[str, float]
    recommendation_text: Optional[str] = None
    status: str
