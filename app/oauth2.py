from datetime import datetime, timedelta

from jose import JWTError, jwt


from fastapi import Depends, status, HTTPException
from fastapi.security import OAuth2PasswordBearer
from sqlalchemy.orm import Session

import schemas_request
import database
import models
from config import settings

oauth2_scheme = OAuth2PasswordBearer(tokenUrl='login')


def create_access_token(data: dict):
    to_encode = data.copy()
    expire = datetime.utcnow() + timedelta(minutes=settings.access_token_expire_minutes)
    to_encode.update({"exp": expire})
    encoded_jwt = jwt.encode(
        to_encode, settings.secret_key, algorithm=settings.algorithm)
    return encoded_jwt


def verify_access_token(token: str):
    try:
        payload = jwt.decode(token, settings.secret_key,
                             algorithms=[settings.algorithm])
        if payload.get("reg_no") is not None:
            reg_no: str = payload.get("reg_no")
            if reg_no is None:
                raise HTTPException(
                    status_code=status.HTTP_401_UNAUTHORIZED, detail="Invalid Credentials", headers={"WWW-Authenticate": "Bearer"}
                )
            token_data = schemas_request.TokenData(reg_no=reg_no)
    except JWTError as exc:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED, detail="Couldn't Verify JWT", headers={"WWW-Authenticate": "Bearer"}
        ) from exc
    return token_data


def get_current_user(token: str = Depends(oauth2_scheme)):
    token_data = verify_access_token(token)
    # user = db.query(models.MasterStudentsPersonal).filter(
    #     models.MasterStudentsPersonal.reg_no == token_data.reg_no).first()
    if token_data.reg_no is None:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED, detail="Invalid Credentials", headers={"WWW-Authenticate": "Bearer"}
        )
    return token_data.reg_no