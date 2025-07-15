# Backtest Strategy

* Backtests have to be as performant as possible and isolated from integration structure with broker or any API.
* Backtests are focusing on the effectiveness, correctness, consistency and at the positive profit of a strategy.
  * So, backtests have unit test character as well as end-to-end tests character without any real integration and with necessary mocks if needed.
* In a single ``smtrader-bot`` node, multiple ``strategy`` runs (multiple days; a single ``strategy`` run for a single day) are started.
* ``strategy`` runs are multithreaded.
* No order management is involved. In every strategy run, upon a signal, it's assumed that the order is always successful.
* I'll visualize and analyse backtest results in my ``smtrader-ui``. So, the backtest results will be persisted in Pastgres DB.

# Trader Backtest Flow

* Load `historical stock data` from ``.csv`` file with time window of the test case depending on decision.
  * For a single ``symbol`` 
  * It could be 1 or more day(s), week(s), month(s) and year(s).
  * Load the data into an ``in memory DB``
* Run a loop for every day in the historical data of the time window:
  * This simulates your regular every day's real run in 1 min. intervals. 
  * Run tick() for every minute:
    * Load `historical stock data` with time window of max. ``2 hours``.
      * This will simulate the loading of the symbol data (that you gather and enhance minute by minute in real run).
      *  From ``in memory DB``
    * Validate ``historical stock data``
      * If not valid, log.
      * There should be also enough tick data to run strategy, if not, log and return.
        * Enough tick means: Until a threshold of missing ticks, it's acceptable to evaluate the rules; rules should be designed to work with last tick data entries, not last minutes. 
    * Get ``latest stock data`` from ``in memory DB`` (that simulates getting from broker)
    * Validate ``latest stock data``
      * If not valid, return.
    * Add ``latest stock data`` to ``historical stock data``
    * Load ``indicator classes``
    * From this step on, the same steps just like in real trader are executed including signal creation until order creation
    * ...
    * Various assertions are made regarding expected values and tresholds on the ``strategy`` run outputs:
      * PnL
      * Signal types & counts
      * Regarding test cases with data validation results and errors etc. 
    * Calculate Backtest metrics below. They could also be checked in unit tests. They are mainly for my analysis in ``smtrader-ui``:
      * Max Drawdown: The largest peak-to-trough decline.
      * Sharpe Ratio / Sortino Ratio: Risk-adjusted returns.
      * Win Rate / Loss Rate: Percentage of profitable/losing trades.
      * Profit Factor: Gross profit / Gross loss.
      * Average Win/Loss Size:
      * Holding Period: Average time trades are open.