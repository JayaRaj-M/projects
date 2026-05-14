from pydantic import BaseModel
from typing import List, Optional
from datetime import datetime


class NoteCreate(BaseModel):
    title: str = "Untitled"
    content: str = ""
    tags: List[str] = []
    color_index: int = 0
    is_pinned: bool = False
    has_voice: bool = False
    voice_path: Optional[str] = None


class NoteUpdate(BaseModel):
    title: Optional[str] = None
    content: Optional[str] = None
    tags: Optional[List[str]] = None
    color_index: Optional[int] = None
    is_pinned: Optional[bool] = None
    has_voice: Optional[bool] = None
    voice_path: Optional[str] = None


class NoteOut(BaseModel):
    id: str
    user_id: str
    title: str
    content: str
    tags: List[str]
    color_index: int
    is_pinned: bool
    has_voice: bool
    voice_path: Optional[str]
    created_at: datetime
    updated_at: datetime

    class Config:
        from_attributes = True