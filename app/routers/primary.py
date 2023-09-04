from fastapi import Depends, HTTPException, status, APIRouter
from pydantic import UUID4

from sqlalchemy.orm import Session
from utils import gen_uuid

from database import get_db, engine

import models
import schemas
import oauth2

router = APIRouter(
    prefix="/api/primary_questions"
)


@router.get("/{language}", response_model=schemas.InitialQuestion)
# @router.get("/", response_model=schemas.GetPrimaryQuestions)
def get_primary_questions(language:str, db: Session = Depends(get_db), user_id: UUID4 = Depends(oauth2.get_current_user)):

    # primary_questions = db.query(models.PrimaryQuestions.question_id).all()
    # question_id_list = []
    # for question in primary_questions:
    #     question_id_list.append(question.question_id)

    primary_questions = db.query(models.PrimaryQuestions.question_id).first()
    question_id = primary_questions.question_id

    journal_id = gen_uuid()
    if language == "en":
        question = db.query(models.Questions).filter(
            models.Questions.id == question_id).first()

        answers = db.query(models.Answers).filter(
            models.Answers.question_id == question_id).all()

    elif language == "hi":
        question = db.query(models.HindiQuestions).filter(
            models.HindiQuestions.id == question_id).first()

        answers = db.query(models.HindiAnswers).filter(
            models.HindiAnswers.question_id == question_id).all()

    else:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST, detail="Language Not Supported")

    response = {"journal_id": journal_id,
                "question": question, "answer_options": answers}

    # return {"question_ids": question_id_list}
    return response


@router.put("/", status_code=status.HTTP_202_ACCEPTED)
def set_primary_questions(payLoad: schemas.SetPrimaryQuestions, db: Session = Depends(get_db), user_id: UUID4 = Depends(oauth2.get_current_user)):
    existing_questions = db.query(models.PrimaryQuestions).delete()
    db.commit()

    new_primary_questions = []
    for question in payLoad.question_ids:
        new_primary_questions.append(
            models.PrimaryQuestions(question_id=question))
    db.add_all(new_primary_questions)
    db.commit()

    return {"Details": "Questions Updated"}
