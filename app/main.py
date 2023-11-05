from sys import prefix
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

from database import engine
from routers import primary, flow, gpt, translate, journal, gpt_journal, auth

import models


app = FastAPI(
    title="Health Chatbot",
    # root_path="/api",
    openapi_url="/api/openapi.json",
    docs_url="/api/docs",
    redoc_url="/api/redoc"
)
origins = ['*']

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

models.Base.metadata.create_all(bind=engine)

app.include_router(auth.router)
app.include_router(primary.router)
app.include_router(flow.router)
app.include_router(gpt.router)
app.include_router(translate.router)
app.include_router(journal.router)
app.include_router(gpt_journal.router)
