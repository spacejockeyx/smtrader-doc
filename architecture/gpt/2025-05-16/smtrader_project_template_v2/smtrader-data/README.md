# smtrader-data

This microservice runs a PostgreSQL database with two schemas:

- `backtest`: stores historical trade signals and backtest results.
- `trader`: stores live order and trade data.

## Folder Structure

smtrader-data/
├── Dockerfile
├── init-db.sh
├── requirements.txt
├── README.md
├── sql/
│   ├── create_schemas.sql
│   ├── create_backtest_tables.sql
│   └── create_trader_tables.sql

## Usage

1. Build and run the Docker container:

```bash
docker build -t smtrader-data .
docker run -p 5432:5432 smtrader-data
````

2. Connect using:

    Host: localhost
    
    Port: 5432
    
    User: smtrader
    
    Password: smtraderpass
    
    Database: smtraderdb
