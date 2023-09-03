from typing import List

from fastapi import FastAPI, Depends, Response, status, HTTPException, APIRouter
from fastapi.params import Body

from pydantic import BaseModel

from sqlalchemy.orm import Session

import models
import schemas
import oauth2
from database import engine, get_db

router = APIRouter(
    tags=["Authentication"],
)

def login():
    access_token = oauth2.create_access_token(data = {"user_id": "user1"})
    return {"access_token" : access_token, "token_type": "bearer"}