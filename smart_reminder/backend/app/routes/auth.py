from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from app.database.session import get_db
from app.schemas.user_schema import UserCreate, UserLogin, UserOut, TokenOut
from app.services.auth_service import AuthService

router = APIRouter()


@router.post("/register", response_model=UserOut, status_code=201)
def register(payload: UserCreate, db: Session = Depends(get_db)):
    return AuthService.register(db, payload)


@router.post("/login", response_model=TokenOut)
def login(payload: UserLogin, db: Session = Depends(get_db)):
    return AuthService.login(db, payload)


@router.get("/me", response_model=UserOut)
def me(db: Session = Depends(get_db), user=Depends(AuthService.get_current_user)):
    return user