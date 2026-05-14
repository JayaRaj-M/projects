from openai import AsyncOpenAI
from app.config.settings import settings
from typing import List, Optional
from app.schemas.ai_schema import ChatMessage

client = AsyncOpenAI(api_key=settings.OPENAI_API_KEY)


class AiService:

    @staticmethod
    async def summarize(text: str) -> str:
        response = await client.chat.completions.create(
            model="gpt-4o-mini",
            messages=[
                {"role": "system", "content": "Summarize the following note concisely in 2-3 sentences."},
                {"role": "user", "content": text},
            ],
            max_tokens=200,
        )
        return response.choices[0].message.content.strip()

    @staticmethod
    async def suggest_tags(text: str) -> List[str]:
        response = await client.chat.completions.create(
            model="gpt-4o-mini",
            messages=[
                {"role": "system", "content": "Extract 3-5 relevant single-word tags from this note. Return only a comma-separated list, no explanations."},
                {"role": "user", "content": text},
            ],
            max_tokens=60,
        )
        raw = response.choices[0].message.content.strip()
        return [t.strip().lower() for t in raw.split(",") if t.strip()]

    @staticmethod
    async def improve_writing(text: str) -> str:
        response = await client.chat.completions.create(
            model="gpt-4o-mini",
            messages=[
                {"role": "system", "content": "Improve the clarity and grammar of the following note. Keep the meaning intact."},
                {"role": "user", "content": text},
            ],
            max_tokens=500,
        )
        return response.choices[0].message.content.strip()

    @staticmethod
    async def chat(message: str, history: Optional[List[ChatMessage]] = None) -> str:
        messages = [{"role": "system", "content": "You are a helpful assistant for a notes app. Help users with their notes."}]
        if history:
            messages += [{"role": m.role, "content": m.content} for m in history]
        messages.append({"role": "user", "content": message})

        response = await client.chat.completions.create(
            model="gpt-4o-mini",
            messages=messages,
            max_tokens=500,
        )
        return response.choices[0].message.content.strip()