import uuid

def generate_session_id() -> str:
    return str(uuid.uuid4())

def generate_task_id() -> str:
    return str(uuid.uuid4())



def select_priority_weak_areas(
    all_data: list,
    max_items: int = 5,
) -> list:
    """
    Pick up to `max_items` weak questions, prioritizing by difficulty.
    Priority order is: foundation -> beginner -> intermediate -> advanced.
    """
    if not all_data:
        return []

    # 1) filter weak questions
    weak = [row for row in all_data if row.get("score", 0) < 75]

    if not weak:
        return []

    # 2) buckets by difficulty
    buckets = {
        "foundation": [],
        "beginner": [],
        "intermediate": [],
        "advanced": [],
    }

    for row in weak:
        diff = (row.get("difficulty") or "").lower()
        if diff in buckets:
            buckets[diff].append(row)
        else:
            # anything unknown goes to intermediate by default
            buckets["intermediate"].append(row)

    # 3) sort each bucket by score ascending (lowest first)
    for diff in buckets:
        buckets[diff].sort(key=lambda r: r.get("score", 0))

    # 4) pick in priority order until we reach max_items
    priority = ["foundation", "beginner", "intermediate", "advanced"]
    selected: list = []

    for diff in priority:
        for row in buckets[diff]:
            if len(selected) >= max_items:
                break
            selected.append(row)
        if len(selected) >= max_items:
            break
    print("selected data", selected)
    return selected
