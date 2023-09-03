from fastapi import Depends, status, APIRouter
from pydantic import UUID4
from typing import List

from sqlalchemy.orm import Session

from database import get_db

import models
import schemas

router = APIRouter(
    prefix="/api/gpt-logs"
)


@router.get("/get/{user_id}/{chat_session_id}", response_model=List[schemas.GPTLogsDetails])
def get_gptlogs(user_id: UUID4, chat_session_id: UUID4, db: Session = Depends(get_db)):
    logs = db.query(models.GPTLogs).filter(
        models.GPTLogs.chat_session_id == chat_session_id,
        models.GPTLogs.user_id == user_id
    ).order_by(
        models.GPTLogs.asked_at
    ).all()
    return logs


@router.get("/get/{user_id}", response_model=List[schemas.UserGPTLogs])
def get_gptlog_id(user_id: UUID4, db: Session = Depends(get_db)):
    chat_session_ids = db.query(models.GPTLogs.chat_session_id).distinct().filter(
        models.GPTLogs.user_id == user_id).all()
    response = []
    for chat_session_id in chat_session_ids:
        asked_at = db.query(models.GPTLogs.asked_at).filter(
            models.GPTLogs.chat_session_id == chat_session_id[0]).first()
        response.append(
            {"asked_at": asked_at[0], "chat_session_id": chat_session_id[0]})
        print(response)
    return response


@router.delete("/delete/{chat_session_id}", status_code=status.HTTP_404_NOT_FOUND)
def delete_gptlogs(chat_session_id: UUID4, db: Session = Depends(get_db)):
    delete_logs = db.query(models.GPTLogs).filter(
        models.GPTLogs.chat_session_id == chat_session_id)
    delete_logs.delete(synchronize_session=False)
    db.commit()

    return {"chat_session_id": chat_session_id}