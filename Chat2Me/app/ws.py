from fastapi import APIRouter, WebSocket, WebSocketDisconnect
import json

router = APIRouter()

active_connections = []


async def broadcast(message: str):
    disconnected = []

    for connection in active_connections:
        try:
            await connection.send_text(message)
        except Exception:
            disconnected.append(connection)

    for connection in disconnected:
        if connection in active_connections:
            active_connections.remove(connection)


@router.websocket("/ws")
async def websocket_endpoint(websocket: WebSocket):
    await websocket.accept()
    active_connections.append(websocket)

    try:
        while True:
            data = await websocket.receive_text()

            # make sure message is valid JSON
            message_data = json.loads(data)

            # send to everyone
            await broadcast(json.dumps(message_data))

    except WebSocketDisconnect:
        if websocket in active_connections:
            active_connections.remove(websocket)