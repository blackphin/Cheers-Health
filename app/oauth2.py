from jose import JWTError, jwt
import schemas
from fastapi import Depends, status, HTTPException
from fastapi.security import OAuth2PasswordBearer
from config import settings

from datetime import datetime, timedelta

oauth2_scheme = OAuth2PasswordBearer(tokenUrl='login')

SECRET_KEY = settings.secret_key
ALGORITHM = settings.algorithm

def create_access_token(data: dict):
    to_encode = data.copy()

    expire = datetime.utcnow() + timedelta(minutes=99999999)
    to_encode.update({"exp": expire})

    encoded_jwt = jwt.encode(to_encode, SECRET_KEY, algorithm=ALGORITHM)

    return encoded_jwt

def verify_access_token(token: str, credentials_exception):

    try:

        payload = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
        id: str = payload.get("user_id")
        if id is None:
            raise credentials_exception
        token_data = schemas.TokenData(id=id)

    except JWTError:
        raise credentials_exception
    return token_data


def get_current_user(token: str = Depends(oauth2_scheme)):
    credentials_exception = HTTPException(
        status_code=status.HTTP_401_UNAUTHORIZED,
        detail="Could not validate credentials",
        headers={"WWW-Authenticate": "Bearer"}
    )

    token = verify_access_token(token, credentials_exception)

    return token.id

# print(create_access_token({"user_id":"497214b0-8422-4354-93bc-e0304837fc0c", "jti":"hello"}))
# print(get_current_user("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiNDk3MjE0YjAtODQyMi00MzU0LTkzYmMtZTAzMDQ4MzdmYzBjIiwianRpIjoiaGVsbG8iLCJleHAiOjc2OTM4MTI5NzJ9.v6KbTD7Rd5Qd0cAy_-pJ5Wj8LW2qnfGCKuGa6RravKg"))