from fastapi import FastAPI, Request
from fastapi.responses import JSONResponse
from fastapi.staticfiles import StaticFiles
from fastapi.templating import Jinja2Templates

from app.ws import router as ws_router

app = FastAPI()

app.mount("/static", StaticFiles(directory="static"), name="static")
templates = Jinja2Templates(directory="templates")

app.include_router(ws_router)


@app.get("/health")
def health():
    return JSONResponse(content={"status": "ok"})


@app.get("/")
def index(request: Request):
    return templates.TemplateResponse("index.html", {"request": request})