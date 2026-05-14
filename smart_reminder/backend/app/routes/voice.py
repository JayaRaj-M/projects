from fastapi import APIRouter, Depends, UploadFile, File, HTTPException
from app.services.speech_service import SpeechService
from app.services.auth_service import AuthService

router = APIRouter()


@router.post("/transcribe")
async def transcribe(
    file: UploadFile = File(...),
    user=Depends(AuthService.get_current_user)
):
    if not file.content_type.startswith("audio/"):
        raise HTTPException(status_code=400, detail="File must be an audio file")

    audio_bytes = await file.read()
    text = await SpeechService.transcribe(audio_bytes, file.filename)
    return {"transcription": text}