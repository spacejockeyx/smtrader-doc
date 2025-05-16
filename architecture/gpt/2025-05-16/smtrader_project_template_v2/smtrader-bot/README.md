
# 📦 smtrader-bot Microservice

This microservice simulates a trading bot that:

- Reads ticker data from CSV
- Analyzes it for BUY/SELL signals
- Provides a REST API for running strategy and placing orders

---

## 📁 Project Structure

smtrader-bot/
├── Dockerfile
├── requirements.txt
├── README.md
├── app/
│ ├── init.py
│ ├── api/
│ │ ├── init.py
│ │ └── routes.py
│ ├── trader/
│ │ ├── init.py
│ │ └── strategy_runner.py
│ ├── ordermanager/
│ │ ├── init.py
│ │ └── manager.py
│ └── main.py
└── data/
└── sample_data.csv


---

## Test Endpoints

    Test endpoints:

    GET / — Status check

    POST /run — Run strategy

    POST /order — Submit mock order