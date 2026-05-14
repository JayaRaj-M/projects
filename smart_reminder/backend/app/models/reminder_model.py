import uuid
from datetime import datetime
from sqlalchemy import Column, String, Text, Boolean, DateTime, ForeignKey, Enum
from app.database.base import Base
import enum


class RepeatType(str, enum.Enum):
    none    = "none"
    daily   = "daily"
    weekly  = "weekly"
    monthly = "monthly"


class Reminder(Base):
    __tablename__ = "reminders"

    id          = Column(String, primary_key=True, default=lambda: str(uuid.uuid4()))
    user_id     = Column(String, ForeignKey("users.id"), nullable=False)
    title       = Column(String(255), nullable=False)
    description = Column(Text, nullable=True)
    date_time   = Column(DateTime, nullable=False)
    is_completed = Column(Boolean, default=False)
    repeat_type = Column(Enum(RepeatType), default=RepeatType.none)
    note_id     = Column(String, nullable=True)
    created_at  = Column(DateTime, default=datetime.utcnow)