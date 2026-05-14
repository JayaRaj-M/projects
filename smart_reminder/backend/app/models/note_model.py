import uuid
from datetime import datetime
from sqlalchemy import Column, String, Text, Boolean, Integer, DateTime, ForeignKey, JSON
from app.database.base import Base


class Note(Base):
    __tablename__ = "notes"

    id         = Column(String, primary_key=True, default=lambda: str(uuid.uuid4()))
    user_id    = Column(String, ForeignKey("users.id"), nullable=False)
    title      = Column(String(255), default="Untitled")
    content    = Column(Text, default="")
    tags       = Column(JSON, default=list)
    color_index = Column(Integer, default=0)
    is_pinned  = Column(Boolean, default=False)
    has_voice  = Column(Boolean, default=False)
    voice_path = Column(String, nullable=True)
    created_at = Column(DateTime, default=datetime.utcnow)
    updated_at = Column(DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)