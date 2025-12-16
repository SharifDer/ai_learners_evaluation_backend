import aiosqlite
import os
from typing import List, Dict, Any, Optional
from contextlib import asynccontextmanager
from app.config import settings
from app.logger import get_logger

logger = get_logger(__name__)


class Database:
    _db_path: str = settings.DATABASE_URL
    
    @classmethod
    async def initialize(cls):
        """Initialize database and create tables if they don't exist"""
        # Ensure directory exists for SQLite file
        os.makedirs(os.path.dirname(cls._db_path), exist_ok=True)
        logger.info(f"Initializing database at: {cls._db_path}")
        await cls._create_tables()
    
    @classmethod
    async def close(cls):
        """Close database connections - placeholder for cleanup if needed"""
        logger.info("Database cleanup completed")
    
    @classmethod
    @asynccontextmanager
    async def connection(cls):
        """Context manager for database connections"""
        async with aiosqlite.connect(cls._db_path) as conn:
            conn.row_factory = aiosqlite.Row  # Enable dict-like access
            yield conn
    
    @classmethod
    async def execute(cls, query: str, params: tuple = None) -> None:
        """Execute a query without returning results"""
        async with cls.connection() as conn:
            await conn.execute(query, params or ())
            await conn.commit()
            logger.debug(f"Executed: {query[:100]}...")
    
    @classmethod
    async def execute_batch(cls, queries: List[tuple]) -> None:
        """
        Execute multiple different queries in a single connection/transaction.
        Each item in `queries` should be (query_str, params_tuple).
        """
        async with cls.connection() as conn:
            for query, params in queries:
                await conn.execute(query, params or ())
            await conn.commit()
            logger.debug(f"Executed batch of {len(queries)} queries")
    
    @classmethod
    async def fetch_one(cls, query: str, params: tuple = None) -> Optional[Dict[str, Any]]:
        """Fetch a single row"""
        async with cls.connection() as conn:
            cursor = await conn.execute(query, params or ())
            row = await cursor.fetchone()
            # logger.debug(f"Fetched one: {query[:100]}...")
            return dict(row) if row else None
    
    @classmethod
    async def fetch_all(cls, query: str, params: tuple = None) -> List[Dict[str, Any]]:
        """Fetch multiple rows"""
        async with cls.connection() as conn:
            cursor = await conn.execute(query, params or ())
            rows = await cursor.fetchall()
            # logger.debug(f"Fetched {len(rows)} rows: {query[:100]}...")
            return [dict(row) for row in rows]
    
    @classmethod
    async def execute_many(cls, query: str, params_list: List[tuple]) -> None:
        """Execute query multiple times with different parameters"""
        async with cls.connection() as conn:
            await conn.executemany(query, params_list)
            await conn.commit()
            logger.debug(f"Executed many ({len(params_list)} times): {query[:100]}...")
    
    @classmethod
    async def health_check(cls) -> bool:
        """Check if database is accessible"""
        try:
            async with cls.connection() as conn:
                await conn.execute("SELECT 1")
            return True
        except Exception as e:
            logger.error(f"Database health check failed: {e}")
            return False
    
    @classmethod
    async def _create_tables(cls):
        """Create all database tables"""
        tables = [
            """
            CREATE TABLE IF NOT EXISTS tracks (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                name TEXT NOT NULL UNIQUE,
                description TEXT,
                created_at DATETIME DEFAULT CURRENT_TIMESTAMP
            );
            """,
            """
            CREATE TABLE IF NOT EXISTS questions (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                text TEXT NOT NULL,
                category TEXT NOT NULL,
                track_id INTEGER NOT NULL,
                difficulty TEXT,
                order_position INTEGER DEFAULT 0,
                created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
                FOREIGN KEY (track_id) REFERENCES tracks(id)
            );
            """,
            """
            CREATE TABLE IF NOT EXISTS answer_options (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                question_id INTEGER NOT NULL,
                option_text TEXT NOT NULL,
                score_weight INTEGER DEFAULT 0,
                order_position INTEGER DEFAULT 0,
                created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
                FOREIGN KEY (question_id) REFERENCES questions(id)
            );
            """,
            """
            CREATE TABLE IF NOT EXISTS sessions (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                session_id TEXT UNIQUE NOT NULL,
                track_id INTEGER NOT NULL,
                status TEXT DEFAULT 'STARTED',
                overall_score JSON,
                recommendation_text TEXT,
                created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
                completed_at DATETIME,
                FOREIGN KEY (track_id) REFERENCES tracks(id)
            );
            """,
            """
            CREATE TABLE IF NOT EXISTS user_responses (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                session_id TEXT NOT NULL,
                question_id INTEGER NOT NULL,
                selected_option_id INTEGER NOT NULL,
                answered_at DATETIME DEFAULT CURRENT_TIMESTAMP,
                FOREIGN KEY (session_id) REFERENCES sessions(session_id),
                FOREIGN KEY (question_id) REFERENCES questions(id),
                FOREIGN KEY (selected_option_id) REFERENCES answer_options(id)
            );
            """
            """
            CREATE TABLE IF NOT EXISTS feedback (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                user_name TEXT,
                feedback_text TEXT,
                created_at DATETIME DEFAULT CURRENT_TIMESTAMP
            );
            """

        ]
        
        async with cls.connection() as conn:
            # Create tables
            for table_sql in tables:
                await conn.executescript(table_sql)
                # logger.debug("Created table")
            
            await conn.commit()
            logger.info("All database tables created successfully")
