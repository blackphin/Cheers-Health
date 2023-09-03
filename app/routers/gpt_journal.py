from fastapi import Depends, Query, status, HTTPException, APIRouter
from pydantic import UUID4
from typing import List, Union

from sqlalchemy.orm import Session

from database import get_db, engine

import models
import schemas

router = APIRouter(
    prefix="/api/journal"
)


@router.get("/get/{type}/{user_id}/{journal_id}", response_model=Union[List[schemas.JournalDetails], List[schemas.GPTLogsDetails]])
def get_journal_details(type: str, user_id: UUID4, journal_id: UUID4, db: Session = Depends(get_db)):
    if type == "flow":
        journals = db.query(models.Journal).filter(
        models.Journal.journal_id == journal_id, models.Journal.user_id == user_id).order_by(models.Journal.answered_at).all()
    elif type == "gpt":
        journals = db.query(models.Journal).filter(
        models.GPTLogs.message_id == journal_id, models.GPTLogs.user_id == user_id).order_by(models.GPTLogs.asked_at).all()


    return journals


@router.get("/get/{type}/{user_id}", response_model=List[schemas.UserJournals])
def get_journal_ids(type: str, user_id: UUID4, db: Session = Depends(get_db)):
    if type == "flow":
        journal_ids = db.query(models.Journal.journal_id).distinct().filter(
            models.Journal.user_id == user_id).all()
        response = []
        for journal_id in journal_ids:
            answered_at = db.query(models.Journal.answered_at).filter(
                models.Journal.journal_id == journal_id[0]).first()
            response.append(
                {"answered_at": answered_at[0], "journal_id": journal_id[0]})
            print(response)
        return response
    elif type == "gpt":
        journal_ids = db.query(models.GPTLogs.chat_session_id).distinct().filter(
            models.GPTLogs.user_id == user_id).all()
        response = []
        for journal_id in journal_ids:
            answered_at = db.query(models.GPTLogs.asked_at).filter(
                models.GPTLogs.chat_session_id == journal_id[0]).first()
            response.append(
                {"answered_at": answered_at[0], "journal_id": journal_id[0]})
            print(response)
        return response


# , response_model=List[schemas.JournalDetails]
@router.put("/update/{log_id}")
def update_journal(log_id: UUID4, db: Session = Depends(get_db)):
    answered_at = db.query(models.Journal.answered_at, models.Journal.question_id).filter(
        models.Journal.log_id == log_id).first()
    delete_logs = db.query(models.Journal).filter(
        models.Journal.answered_at >= answered_at.answered_at)
    delete_logs.delete(synchronize_session=False)
    db.commit()

    return {"answered_at": answered_at.answered_at, "question_id": answered_at.question_id}

@router.delete("/delete/{type}/{journal_id}")
def delete_journal(type: str, journal_id: UUID4, db: Session = Depends(get_db)):
    delete_logs = db.query(models.Journal).filter(
        models.Journal.journal_id == journal_id)
    delete_logs.delete(synchronize_session=False)
    db.commit()

    return {"journal_id": journal_id}