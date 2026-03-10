# Chat2Me
Simple multi-user chat application using FastAPI and WebSockets.

## Requirements

- Python 3.10+
- pip

## Install

```bash
python -m venv .venv
source .venv/bin/activate   # Windows: .venv\Scripts\activate
pip install -r requirements.txt

## Run app (start the api server)

command - uvicorn app.main:app --host 0.0.0.0 --port $PORT
