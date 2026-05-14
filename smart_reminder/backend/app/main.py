from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from app.routes import notes, reminders, ai, voice, auth
from app.database.db import engine
from app.database.base import Base
from app.utils.logger import logger

# Create all tables
Base.metadata.create_all(bind=engine)

app = FastAPI(
    title="Smart Notes API",
    description="AI-powered notes backend",
    version="1.0.0"
)

# CORS
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Routers
app.include_router(auth.router,      prefix="/api/v1/auth",      tags=["Auth"])
app.include_router(notes.router,     prefix="/api/v1/notes",     tags=["Notes"])
app.include_router(reminders.router, prefix="/api/v1/reminders", tags=["Reminders"])
app.include_router(ai.router,        prefix="/api/v1/ai",        tags=["AI"])
app.include_router(voice.router,     prefix="/api/v1/voice",     tags=["Voice"])


@app.get("/")
def root():
    logger.info("Root endpoint hit")
    return {"message": "Smart Notes API is running"}


@app.get("/health")
def health():
    return {"status": "ok"}