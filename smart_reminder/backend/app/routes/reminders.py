from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from typing import List
from app.database.session import get_db
from app.schemas.reminder_schema import ReminderCreate, ReminderUpdate, ReminderOut
from app.models.reminder_model import Reminder
from app.services.auth_service import AuthService

router = APIRouter()


@router.get("/", response_model=List[ReminderOut])
def get_reminders(db: Session = Depends(get_db), user=Depends(AuthService.get_current_user)):
    return db.query(Reminder).filter(Reminder.user_id == user.id).order_by(Reminder.date_time).all()


@router.post("/", response_model=ReminderOut, status_code=201)
def create_reminder(payload: ReminderCreate, db: Session = Depends(get_db), user=Depends(AuthService.get_current_user)):
    reminder = Reminder(**payload.dict(), user_id=user.id)
    db.add(reminder)
    db.commit()
    db.refresh(reminder)
    return reminder


@router.get("/{reminder_id}", response_model=ReminderOut)
def get_reminder(reminder_id: str, db: Session = Depends(get_db), user=Depends(AuthService.get_current_user)):
    reminder = db.query(Reminder).filter(Reminder.id == reminder_id, Reminder.user_id == user.id).first()
    if not reminder:
        raise HTTPException(status_code=404, detail="Reminder not found")
    return reminder


@router.put("/{reminder_id}", response_model=ReminderOut)
def update_reminder(reminder_id: str, payload: ReminderUpdate, db: Session = Depends(get_db), user=Depends(AuthService.get_current_user)):
    reminder = db.query(Reminder).filter(Reminder.id == reminder_id, Reminder.user_id == user.id).first()
    if not reminder:
        raise HTTPException(status_code=404, detail="Reminder not found")
    for key, value in payload.dict(exclude_unset=True).items():
        setattr(reminder, key, value)
    db.commit()
    db.refresh(reminder)
    return reminder


@router.delete("/{reminder_id}", status_code=204)
def delete_reminder(reminder_id: str, db: Session = Depends(get_db), user=Depends(AuthService.get_current_user)):
    reminder = db.query(Reminder).filter(Reminder.id == reminder_id, Reminder.user_id == user.id).first()
    if not reminder:
        raise HTTPException(status_code=404, detail="Reminder not found")
    db.delete(reminder)
    db.commit()