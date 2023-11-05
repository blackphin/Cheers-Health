from fastapi import APIRouter, Depends, status, HTTPException
from fastapi.security.oauth2 import OAuth2PasswordRequestForm
from sqlalchemy.orm import Session

import database
import schemas
import models
import utils
import oauth2

router = APIRouter(tags=['Authentication'], prefix='/api/auth')


@router.get('/login', response_model=schemas.Token)
def login(
    user_credentials: OAuth2PasswordRequestForm = Depends(),
    db: Session = Depends(database.get_db)
):
    try:
        int(user_credentials.username)
        user = db.query(models.Users.id, models.Users.password).filter(
            models.Users.phone == user_credentials.username).first()
    except ValueError:
        user = db.query(models.Users.id, models.Users.password).filter(
            models.Users.email == user_credentials.username).first()

    if not user:
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN, detail="Invalid Credentials")

    if not utils.verify(user_credentials.password, user.password):
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN, detail="Invalid Credentials")

    access_token = oauth2.create_access_token(data={"user_id": str(user.id)})
    return {"access_token": access_token, "token_type": "bearer"}


@router.post('/createaccount', response_model=schemas.Token)
def create_account(user_details: schemas.CreateUser, db: Session = Depends(database.get_db)):
    existing_user = db.query(models.Users.id).filter(
        models.Users.email == user_details.email).first()
    if not existing_user:
        user_details.password = utils.hash_pass(user_details.password)
        new_user = models.Users(**user_details.dict())
        db.add(new_user)
        db.commit()
        db.refresh(new_user)
    else:
        raise HTTPException(
            status_code=status.HTTP_409_CONFLICT, detail="User already Exists"
        )
    user_id = db.query(models.Users.id).filter(
        models.Users.email == user_details.email).first()

    access_token = oauth2.create_access_token(
        data={"user_id": str(user_id.id)})

    return {"access_token": access_token, "token_type": "bearer"}
