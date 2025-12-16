from fastapi import FastAPI, Request
from fastapi.middleware.cors import CORSMiddleware
from contextlib import asynccontextmanager
from app.database.db import Database
from app.routes import assessment, questions, results
from app.logger import get_logger
from app.routes import feedback

logger = get_logger(__name__)


@asynccontextmanager
async def lifespan(app: FastAPI):
    # Initialize DB (Validation/Creation)
    await Database.initialize()
    
    # Check if we need to seed
    try:
        row = await Database.fetch_one("SELECT count(*) as c FROM tracks")
        if row and row['c'] == 0:
            logger.info("Seeding database initial data...")
            with open("data/seed_questions.sql", "r") as f:
                script = f.read()
                async with Database.connection() as conn:
                    await conn.executescript(script)
                    await conn.commit()
            logger.info("Seeding complete.")
    except Exception as e:
        logger.error(f"Seeding failed: {e}")
        
    yield
    
    await Database.close()


app = FastAPI(title="Skill Assessment API", lifespan=lifespan)


app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


app.include_router(assessment.router, prefix="/assessment", tags=["Assessment"])
app.include_router(questions.router, prefix="/questions", tags=["Questions"])
app.include_router(results.router, prefix="/results", tags=["Results"])
app.include_router(feedback.router, prefix="/api", tags=["feedback"])


@app.get("/")
def root():
    return {"message": "Skill Assessment API Operational"}
