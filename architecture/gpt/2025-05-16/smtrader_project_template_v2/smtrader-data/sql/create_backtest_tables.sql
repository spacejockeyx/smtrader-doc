CREATE TABLE IF NOT EXISTS backtest.trade_signals (
    id SERIAL PRIMARY KEY,
    symbol VARCHAR(20) NOT NULL,
    signal_time TIMESTAMP NOT NULL,
    signal_type VARCHAR(10) NOT NULL,
    price NUMERIC(12,4) NOT NULL
);

CREATE TABLE IF NOT EXISTS backtest.trade_results (
    id SERIAL PRIMARY KEY,
    trade_signal_id INT NOT NULL REFERENCES backtest.trade_signals(id),
    executed_time TIMESTAMP,
    executed_price NUMERIC(12,4),
    profit_loss NUMERIC(12,4)
);
