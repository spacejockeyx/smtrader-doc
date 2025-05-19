# smtrader-ui

Web dashboard for managing and monitoring trading bots.

This microservice provides a web-based dashboard to:

    Monitor trader bots (running under smtrader-bot)

    Send control commands to smtrader-executer

    View aggregated data: profit, loss, budgets, and orders

    Show and interact with historical/backtest data from smtrader-data

## Features

- View bot status and live performance
- Start/stop bots via smtrader-executer API
- View trading statistics (profit, orders, positions)
- Fetch data from smtrader-data backend

````Folder Structure
smtrader-ui/
├── frontend/
│   ├── public/
│   ├── src/
│   │   ├── components/
│   │   ├── pages/
│   │   ├── services/
│   │   └── App.tsx
│   ├── .env
│   ├── package.json
│   └── tsconfig.json
├── docker/
│   └── Dockerfile
└── README.md

````

# Tech Stack

    Frontend: React (with TypeScript)

    Styling: Tailwind CSS

    Data Fetching: Axios + REST API calls to other services (Executer, Data, etc.)


# Key Features

    🔍 Node status overview (list of all active bot nodes)

    📊 Global statistics (profit, loss, budgets, etc.)

    🧠 Control Panel (start/stop trading bots via Executer API)

    📈 Visualizations of orders, trades, historical data


## Development

```bash
cd frontend
npm install
npm run dev
```

## Production

```
docker build -t smtrader-ui ./docker
docker run -p 80:80 smtrader-ui
```bash

