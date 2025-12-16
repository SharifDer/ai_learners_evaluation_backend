"""Assessment processing service - now rule-based"""
import json
from app.database.db import Database
from app.services.feedback_rules import generate_rule_based_feedback
from app.config import settings
from app.logger import get_logger


logger = get_logger(__name__)


# In-memory store for task status 
TASK_STATUS = {}


async def calculate_scores(session_id: str):
    """
    Calculate scores based on user responses.
    Returns: {"total": 85.0, "Foundations": 90.0, ...}
    """
    query = """
    SELECT q.category, ao.score_weight
    FROM user_responses ur
    JOIN questions q ON ur.question_id = q.id
    JOIN answer_options ao ON ur.selected_option_id = ao.id
    WHERE ur.session_id = ?
    """
    rows = await Database.fetch_all(query, (session_id,))
    
    if not rows:
        return {"total": 0.0}
    
    category_data = {} # {cat: [scores...]}
    
    for row in rows:
        cat = row['category']
        weight = row['score_weight']
        if cat not in category_data:
            category_data[cat] = []
        category_data[cat].append(weight)
        
    final_scores = {}
    total_sum = 0
    total_count = 0
    
    for cat, scores in category_data.items():
        avg = sum(scores) / len(scores) if scores else 0
        final_scores[cat] = round(avg, 2)
        total_sum += sum(scores)
        total_count += len(scores)
        
    final_scores['total'] = round(total_sum / total_count, 2) if total_count > 0 else 0
    return final_scores


async def get_weak_areas(session_id: str):
    """Fetch questions where the user scored low (< 75)"""
    query = """
    SELECT q.id as question_id, q.text, q.category, ao.score_weight as score
    FROM user_responses ur
    JOIN questions q ON ur.question_id = q.id
    JOIN answer_options ao ON ur.selected_option_id = ao.id
    WHERE ur.session_id = ? AND ao.score_weight < 75
    ORDER BY ao.score_weight ASC
    """
    rows = await Database.fetch_all(query, (session_id,))
    return [dict(row) for row in rows]


async def process_assessment_results(session_id: str, task_id: str):
    """Background task to score and generate recommendation"""
    print(f"[DEBUG] Starting processing for {session_id}")
    TASK_STATUS[task_id] = "PROCESSING"
    
    # 1. Scoring
    print("[DEBUG] Calculating scores...")
    scores = await calculate_scores(session_id)
    print(f"[DEBUG] Scores: {scores}")
    
    # 2. Context Gathering
    weak_areas = await get_weak_areas(session_id)
    print(f"[DEBUG] Weak areas count: {len(weak_areas)}")
    
    # 3. Rule-based feedback (CHANGED FROM GEMINI)
    recommendation = generate_rule_based_feedback(scores, weak_areas)
    
    # 4. Persistence
    await Database.execute(
        """
        UPDATE sessions 
        SET overall_score = ?, recommendation_text = ?, status = 'COMPLETED', completed_at = CURRENT_TIMESTAMP
        WHERE session_id = ?
        """,
        (json.dumps(scores), recommendation, session_id)
    )
    
    TASK_STATUS[task_id] = "COMPLETED"
    logger.info(f"Task {task_id} completed.")
