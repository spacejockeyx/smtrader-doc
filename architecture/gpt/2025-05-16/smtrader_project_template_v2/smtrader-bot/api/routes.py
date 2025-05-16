from fastapi import APIRouter
from app.trader.strategy_runner import start_strategy
from app.ordermanager.manager import place_order

router = APIRouter()

@router.get("/")
def root():
    return {"message": "Bot is running."}

@router.post("/run")
def run_bot():
    result = start_strategy()
    return {"status": "running", "result": result}

@router.post("/order")
def order():
    return place_order("AAPL", 10, "BUY")
