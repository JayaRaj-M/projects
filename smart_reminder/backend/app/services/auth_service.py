from fastapi import Depends, HTTPException, status
from fastapi.security import HTTPBearer, HTTPAuthorizationCredentials
from sqlalchemy.orm import Session
from app.database.session import get_db
from app.models.user_model import User
from app.schemas.user_schema import UserCreate, UserLogin
from app.utils.hashing import Hash
from app.utils.jwt_handler import JWTHandler

bearer_scheme = HTTPBearer()


class AuthService:

    @staticmethod
    def register(db: Session, payload: UserCreate) -> User:
        existing = db.query(User).filter(User.email == payload.email).first()
        if existing:
            raise HTTPException(status_code=400, detail="Email already registered")
        user = User(
            name=payload.name,
            email=payload.email,
            password=Hash.bcrypt(payload.password),
        )
        db.add(user)
        db.commit()
        db.refresh(user)
        return user

    @staticmethod
    def login(db: Session, payload: UserLogin) -> dict:
        user = db.query(User).filter(User.email == payload.email).first()
        if not user or not Hash.verify(payload.password, user.password):
            raise HTTPException(status_code=401, detail="Invalid credentials")
        token = JWTHandler.create_token({"sub": user.id})
        return {"access_token": token, "token_type": "bearer", "user": user}

    @staticmethod
    def get_current_user(
        credentials: HTTPAuthorizationCredentials = Depends(bearer_scheme),
        db: Session = Depends(get_db),
    ) -> User:
        token = credentials.credentials
        payload = JWTHandler.decode_token(token)
        user_id = payload.get("sub")
        user = db.query(User).filter(User.id == user_id).first()
        if not user:
            raise HTTPException(status_code=401, detail="User not found")
        return user