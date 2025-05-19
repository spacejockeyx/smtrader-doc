# A FastAPI app exposing REST endpoints to control and monitor the IBKR Gateway.
from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
from ibkr_client import IBKRClient

app = FastAPI()
ibkr_client = IBKRClient()

class ConnectRequest(BaseModel):
    username: str
    password: str

@app.post("/connect")
async def connect(data: ConnectRequest):
    success = ibkr_client.connect(data.username, data.password)
    if success:
        return {"status": "connected"}
    else:
        raise HTTPException(status_code=500, detail="Failed to connect")

@app.post("/disconnect")
async def disconnect():
    ibkr_client.disconnect()
    return {"status": "disconnected"}

@app.get("/status")
async def status():
    return {"connected": ibkr_client.is_connected()}
