from fastapi import APIRouter
from app.database.db import Database

router = APIRouter()

@router.post("/feedback")
async def submit_feedback(user_name: str, feedback_text: str):
    await Database.execute(
        "INSERT INTO feedback (user_name, feedback_text) VALUES (?, ?)",
        (user_name, feedback_text)
    )
    return {"message": "Feedback submitted"}
