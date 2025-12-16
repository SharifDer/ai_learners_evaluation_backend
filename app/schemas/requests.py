from pydantic import BaseModel, Field
from typing import List

class StartAssessment(BaseModel):
    track: str = Field(..., description="Track name, e.g., 'ML' or 'DS'")

class AnswerSubmission(BaseModel):
    question_id: int
    selected_option_id: int

class SubmitAnswers(BaseModel):
    session_id: str
    answers: List[AnswerSubmission]

class CompleteAssessment(BaseModel):
    session_id: str
