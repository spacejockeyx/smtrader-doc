def place_order(symbol: str, qty: int, side: str):
    # Mocked for now
    return {
        "status": "submitted",
        "symbol": symbol,
        "quantity": qty,
        "side": side
    }