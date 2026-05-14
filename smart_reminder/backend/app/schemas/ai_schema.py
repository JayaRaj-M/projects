from pydantic import BaseModel
from typing import List, Optional


class SummarizeRequest(BaseModel):
    text: str


class SummarizeResponse(BaseModel):
    summary: str


class TagRequest(BaseModel):
    text: str


class TagResponse(BaseModel):
    tags: List[str]


class ImproveRequest(BaseModel):
    text: str


class ImproveResponse(BaseModel):
    improved: str


class ChatMessage(BaseModel):
    role: str   # "user" or "assistant"
    content: str


class ChatRequest(BaseModel):
    message: str
    history: Optional[List[ChatMessage]] = []


class ChatResponse(BaseModel):
    reply: str