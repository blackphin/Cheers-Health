from fastapi import Depends, APIRouter, status
from pydantic import UUID4
from typing import List

from sqlalchemy.orm import Session

from database import get_db

import models
import schemas
import oauth2

router = APIRouter(
    prefix="/api/journal"
)


@router.get("/get/{journal_id}", response_model=List[schemas.JournalDetails])
def get_journal_details(
    journal_id: UUID4,
    db: Session = Depends(get_db),
    user_id: UUID4 = Depends(oauth2.get_current_user)
):

    journals = db.query(models.Journal).filter(
        models.Journal.journal_id == journal_id, models.Journal.user_id == user_id).order_by(models.Journal.answered_at
    ).all()
    return journals


@router.get("/get", response_model=List[schemas.UserJournals])
def get_journal_ids(
    db: Session = Depends(get_db),
    user_id: UUID4 = Depends(oauth2.get_current_user)
):

    journal_ids = db.query(models.Journal.journal_id).distinct().filter(
        models.Journal.user_id == user_id
    ).all()
    response = []
    for journal_id in journal_ids:
        answered_at = db.query(models.Journal.answered_at).filter(
            models.Journal.journal_id == journal_id[0]).first()
        response.append(
            {"answered_at": answered_at[0], "journal_id": journal_id[0]}
        )
    return response

# , response_model=List[schemas.JournalDetails]
@router.put("/update/{log_id}")
def update_journal(log_id: UUID4, db: Session = Depends(get_db), user_id: UUID4 = Depends(oauth2.get_current_user)):
    answered_at = db.query(models.Journal.answered_at, models.Journal.question_id).filter(
        models.Journal.log_id == log_id,
        models.Journal.user_id == user_id
    ).first()
    delete_logs = db.query(models.Journal).filter(
        models.Journal.answered_at >= answered_at.answered_at
    )
    delete_logs.delete(synchronize_session=False)
    db.commit()

    return {"answered_at": answered_at.answered_at, "question_id": answered_at.question_id}


@router.delete("/delete/{journal_id}", status_code=status.HTTP_404_NOT_FOUND)
def delete_journal(journal_id: UUID4, db: Session = Depends(get_db), user_id: UUID4 = Depends(oauth2.get_current_user)):
    delete_logs = db.query(models.Journal).filter(
        models.Journal.journal_id == journal_id,
        models.Journal.user_id == user_id
    )
    delete_logs.delete(synchronize_session=False)
    db.commit()

    return {"journal_id": journal_id}