from sqlalchemy.orm import Session
from datetime import datetime
from app.models.reminder_model import Reminder
from app.utils.logger import logger


class ReminderService:

    @staticmethod
    def get_due_reminders(db: Session) -> list:
        """Returns all reminders that are due now and not completed."""
        now = datetime.utcnow()
        due = db.query(Reminder).filter(
            Reminder.date_time <= now,
            Reminder.is_completed == False
        ).all()
        logger.info(f"Found {len(due)} due reminders")
        return due

    @staticmethod
    def mark_complete(db: Session, reminder_id: str) -> None:
        reminder = db.query(Reminder).filter(Reminder.id == reminder_id).first()
        if reminder:
            reminder.is_completed = True
            db.commit()
            logger.info(f"Reminder {reminder_id} marked complete")