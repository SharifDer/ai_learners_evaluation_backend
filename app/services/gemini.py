"""Assessment processing service"""
import json
from app.database.db import Database
from app.services.feedback_rules import generate_rule_based_feedback
from app.config import settings
from app.logger import get_logger

logger = get_logger(__name__)

# In-memory store for task status 
TASK_STATUS = {}


async def get_assessment_data(session_id: str):
    """Single query to fetch all response data"""
    query = """
    SELECT q.id as question_id, q.text, q.category, ao.score_weight as score
    FROM user_responses ur
    JOIN questions q ON ur.question_id = q.id
    JOIN answer_options ao ON ur.selected_option_id = ao.id
    WHERE ur.session_id = ?
    ORDER BY ao.score_weight ASC
    """
    rows = await Database.fetch_all(query, (session_id,))
    return [dict(row) for row in rows]


def calculate_scores_from_data(data: list):
    """Calculate scores from fetched data (in-memory, no DB calls)"""
    if not data:
        return {"total": 0.0}
    
    category_data = {}
    
    for row in data:
        cat = row['category']
        weight = row['score']
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


async def process_assessment_results(session_id: str, task_id: str):
    """Process assessment with single DB query"""
    print(f"[DEBUG] Starting processing for {session_id}")
    TASK_STATUS[task_id] = "PROCESSING"
    
    # Single DB call for all data
    all_data = await get_assessment_data(session_id)
    
    # Calculate scores (in-memory)
    scores = calculate_scores_from_data(all_data)
    weak_areas = [row for row in all_data if row['score'] < 75]
 
    # Generate feedback
    if settings.USE_LLM_FEEDBACK:
        from app.services.feedback_rules import generate_llm_feedback
        recommendation = await generate_llm_feedback(scores, weak_areas)
        logger.info("feedback has been generted with LLM")
    else:
        recommendation = generate_rule_based_feedback(scores, weak_areas)
    
    # Update session
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
