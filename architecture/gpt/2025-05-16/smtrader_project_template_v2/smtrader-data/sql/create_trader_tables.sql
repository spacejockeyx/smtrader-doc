CREATE TABLE IF NOT EXISTS trader.orders (
    id SERIAL PRIMARY KEY,
    symbol VARCHAR(20) NOT NULL,
    order_time TIMESTAMP NOT NULL,
    quantity INT NOT NULL,
    order_type VARCHAR(10) NOT NULL,
    status VARCHAR(20) NOT NULL
);

CREATE TABLE IF NOT EXISTS trader.trades (
    id SERIAL PRIMARY KEY,
    order_id INT NOT NULL REFERENCES trader.orders(id),
    executed_time TIMESTAMP,
    executed_price NUMERIC(12,4),
    profit_loss NUMERIC(12,4)
);