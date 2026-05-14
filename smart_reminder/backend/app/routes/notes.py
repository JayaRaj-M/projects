from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from typing import List
from app.database.session import get_db
from app.schemas.note_schema import NoteCreate, NoteUpdate, NoteOut
from app.models.note_model import Note
from app.services.auth_service import AuthService

router = APIRouter()


@router.get("/", response_model=List[NoteOut])
def get_notes(db: Session = Depends(get_db), user=Depends(AuthService.get_current_user)):
    return db.query(Note).filter(Note.user_id == user.id).order_by(Note.updated_at.desc()).all()


@router.post("/", response_model=NoteOut, status_code=201)
def create_note(payload: NoteCreate, db: Session = Depends(get_db), user=Depends(AuthService.get_current_user)):
    note = Note(**payload.dict(), user_id=user.id)
    db.add(note)
    db.commit()
    db.refresh(note)
    return note


@router.get("/{note_id}", response_model=NoteOut)
def get_note(note_id: str, db: Session = Depends(get_db), user=Depends(AuthService.get_current_user)):
    note = db.query(Note).filter(Note.id == note_id, Note.user_id == user.id).first()
    if not note:
        raise HTTPException(status_code=404, detail="Note not found")
    return note


@router.put("/{note_id}", response_model=NoteOut)
def update_note(note_id: str, payload: NoteUpdate, db: Session = Depends(get_db), user=Depends(AuthService.get_current_user)):
    note = db.query(Note).filter(Note.id == note_id, Note.user_id == user.id).first()
    if not note:
        raise HTTPException(status_code=404, detail="Note not found")
    for key, value in payload.dict(exclude_unset=True).items():
        setattr(note, key, value)
    db.commit()
    db.refresh(note)
    return note


@router.delete("/{note_id}", status_code=204)
def delete_note(note_id: str, db: Session = Depends(get_db), user=Depends(AuthService.get_current_user)):
    note = db.query(Note).filter(Note.id == note_id, Note.user_id == user.id).first()
    if not note:
        raise HTTPException(status_code=404, detail="Note not found")
    db.delete(note)
    db.commit()