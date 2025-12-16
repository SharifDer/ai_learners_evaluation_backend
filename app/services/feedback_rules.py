"""Rule-based feedback generation system"""

# Topic grouping: maps question IDs to general topics
TOPIC_GROUPS = {
    "Python and software fundamentals": [1, 8, 9, 27, 29, 36, 37, 55],
    "version control and collaboration": [2, 30],
    "API development and integration": [3, 4, 21, 31, 32, 52],
    "understanding evaluation metrics": [5, 33],
    "overfitting and model validation": [6, 10, 16, 34, 38],
    "data leakage and feature engineering": [7, 14, 35],
    "working with messy real-world data": [11, 12, 39, 40, 43],
    "model monitoring and drift": [13, 26],
    "handling imbalanced datasets": [15],
    "debugging model behavior": [17, 18],
    "ML project methodology": [19],
    "production deployment readiness": [20, 28],
    "web frameworks": [22],
    "containerization and environments": [23],
    "database and data persistence": [24, 53],
    "model versioning and experiment tracking": [25],
    "statistical analysis and hypothesis testing": [41],
    "data visualization and communication": [42, 47],
    "correlation and feature relationships": [44],
    "sample size and generalization": [45, 46],
    "SQL and data querying": [48],
    "workflow automation and pipelines": [49],
    "BI tools and dashboards": [50],
    "cloud platforms and infrastructure": [51],
    "reproducibility and documentation": [55, 56],
}

# Reverse mapping: question_id -> topic
QUESTION_TO_TOPIC = {}
for topic, question_ids in TOPIC_GROUPS.items():
    for qid in question_ids:
        QUESTION_TO_TOPIC[qid] = topic

# Actionable guidance per topic
TOPIC_ACTIONS = {
    "Python and software fundamentals": "Build small projects focusing on clean code and testing",
    "version control and collaboration": "Practice resolving merge conflicts on a test repository",
    "API development and integration": "Create a simple REST API and consume external APIs",
    "understanding evaluation metrics": "Practice choosing metrics based on business context",
    "overfitting and model validation": "Experiment with regularization techniques on a practice dataset",
    "data leakage and feature engineering": "Review feature creation pipelines for temporal leakage",
    "working with messy real-world data": "Clean and analyze a messy public dataset end-to-end",
    "model monitoring and drift": "Set up logging to track model predictions over time",
    "handling imbalanced datasets": "Practice with resampling and cost-sensitive learning",
    "debugging model behavior": "Systematically analyze error patterns in predictions",
    "ML project methodology": "Follow an iterative baseline-first approach on a new problem",
    "production deployment readiness": "Deploy a small model with proper error handling",
    "web frameworks": "Build a simple FastAPI application with multiple endpoints",
    "containerization and environments": "Containerize a Python application and run it locally",
    "database and data persistence": "Design a schema and implement CRUD operations",
    "model versioning and experiment tracking": "Document experiments with parameters and results",
    "statistical analysis and hypothesis testing": "Run A/B test simulations with proper significance testing",
    "data visualization and communication": "Create charts that tell clear stories for stakeholders",
    "correlation and feature relationships": "Analyze feature correlations and their impact on models",
    "sample size and generalization": "Study sampling bias in real-world scenarios",
    "SQL and data querying": "Practice complex JOINs and aggregations",
    "workflow automation and pipelines": "Automate a recurring analysis task",
    "BI tools and dashboards": "Build an interactive dashboard for a sample dataset",
    "cloud platforms and infrastructure": "Deploy a simple service to a cloud platform",
    "reproducibility and documentation": "Create fully reproducible analysis with clear documentation",
}


def generate_rule_based_feedback(scores: dict, weak_areas: list) -> str:
    """
    Generate personalized feedback without LLM
    
    Args:
        scores: {"total": 68, "Foundations": 75, ...}
        weak_areas: [{"question_id": 13, "text": "...", "category": "...", "score": 25}, ...]
    
    Returns:
        Feedback string
    """
    total = scores.get('total', 0)
    
    # Extract unique topics from weak questions (top 3)
    weak_topics = []
    seen_topics = set()
    
    for area in weak_areas[:6]:  # Check more questions to get 3 unique topics
        qid = area.get('question_id')
        if qid in QUESTION_TO_TOPIC:
            topic = QUESTION_TO_TOPIC[qid]
            if topic not in seen_topics:
                weak_topics.append(topic)
                seen_topics.add(topic)
        
        if len(weak_topics) >= 3:
            break
    
    # Determine tone based on score bands
    if total >= 80:
        intro = "You're performing well overall"
        action_verb = "Refine"
    elif total >= 60:
        intro = "You have solid foundations but gaps in practical areas"
        action_verb = "Focus on"
    elif total >= 40:
        intro = "You understand concepts but need more hands-on experience"
        action_verb = "Build skills in"
    else:
        intro = "You're at the early stages"
        action_verb = "Start with"
    
    # Format topic list
    if len(weak_topics) >= 3:
        topic_text = f"{weak_topics[0]}, {weak_topics[1]}, and {weak_topics[2]}"
        action_text = TOPIC_ACTIONS.get(weak_topics[0], "practice with real projects")
    elif len(weak_topics) == 2:
        topic_text = f"{weak_topics[0]} and {weak_topics[1]}"
        action_text = TOPIC_ACTIONS.get(weak_topics[0], "practice with real projects")
    elif len(weak_topics) == 1:
        topic_text = weak_topics[0]
        action_text = TOPIC_ACTIONS.get(weak_topics[0], "practice with real projects")
    else:
        topic_text = "core fundamentals"
        action_text = "build small projects to gain practical experience"
    
    # Construct final feedback
    feedback = f"{intro}. {action_verb} {topic_text}. {action_text.capitalize()}."
    
    return feedback
