import io
from openai import AsyncOpenAI
from app.config.settings import settings

client = AsyncOpenAI(api_key=settings.OPENAI_API_KEY)


class SpeechService:

    @staticmethod
    async def transcribe(audio_bytes: bytes, filename: str = "audio.wav") -> str:
        """Transcribe audio bytes using OpenAI Whisper."""
        audio_file = io.BytesIO(audio_bytes)
        audio_file.name = filename

        response = await client.audio.transcriptions.create(
            model="whisper-1",
            file=audio_file,
        )
        return response.text