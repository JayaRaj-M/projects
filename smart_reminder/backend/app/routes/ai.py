from fastapi import APIRouter, Depends
from app.schemas.ai_schema import (
    SummarizeRequest, SummarizeResponse,
    TagRequest, TagResponse,
    ImproveRequest, ImproveResponse,
    ChatRequest, ChatResponse,
)
from app.services.ai_service import AiService
from app.services.auth_service import AuthService

router = APIRouter()


@router.post("/summarize", response_model=SummarizeResponse)
async def summarize(payload: SummarizeRequest, user=Depends(AuthService.get_current_user)):
    summary = await AiService.summarize(payload.text)
    return {"summary": summary}


@router.post("/tags", response_model=TagResponse)
async def suggest_tags(payload: TagRequest, user=Depends(AuthService.get_current_user)):
    tags = await AiService.suggest_tags(payload.text)
    return {"tags": tags}


@router.post("/improve", response_model=ImproveResponse)
async def improve(payload: ImproveRequest, user=Depends(AuthService.get_current_user)):
    improved = await AiService.improve_writing(payload.text)
    return {"improved": improved}


@router.post("/chat", response_model=ChatResponse)
async def chat(payload: ChatRequest, user=Depends(AuthService.get_current_user)):
    reply = await AiService.chat(payload.message, payload.history)
    return {"reply": reply}