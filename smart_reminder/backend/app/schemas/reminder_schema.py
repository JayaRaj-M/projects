from pydantic import BaseModel
from typing import Optional
from datetime import datetime
from app.models.reminder_model import RepeatType


class ReminderCreate(BaseModel):
    title: str
    description: Optional[str] = None
    date_time: datetime
    repeat_type: RepeatType = RepeatType.none
    note_id: Optional[str] = None


class ReminderUpdate(BaseModel):
    title: Optional[str] = None
    description: Optional[str] = None
    date_time: Optional[datetime] = None
    is_completed: Optional[bool] = None
    repeat_type: Optional[RepeatType] = None


class ReminderOut(BaseModel):
    id: str
    user_id: str
    title: str
    description: Optional[str]
    date_time: datetime
    is_completed: bool
    repeat_type: RepeatType
    note_id: Optional[str]
    created_at: datetime

    class Config:
        from_attributes = True