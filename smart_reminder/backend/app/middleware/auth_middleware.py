from fastapi import Request
from starlette.middleware.base import BaseHTTPMiddleware
from starlette.responses import JSONResponse
from app.utils.logger import logger

# Public routes that don't need auth headers logged as protected
PUBLIC_PATHS = {"/", "/health", "/api/v1/auth/login", "/api/v1/auth/register", "/docs", "/openapi.json"}


class AuthMiddleware(BaseHTTPMiddleware):
    async def dispatch(self, request: Request, call_next):
        path = request.url.path

        if path not in PUBLIC_PATHS:
            auth_header = request.headers.get("Authorization")
            if not auth_header:
                logger.warning(f"Missing Authorization header for {path}")
                # Let FastAPI dependency handle the actual 401; this just logs
            else:
                logger.debug(f"Authorized request to {path}")

        try:
            response = await call_next(request)
        except Exception as e:
            logger.error(f"Unhandled error: {e}")
            return JSONResponse(status_code=500, content={"detail": "Internal server error"})

        return response