# Tasks

* smtrader-bot: Persist Backtest Results in Postgres
  * Here I Am: Backets trader.py:
    * strategy_results_map_with_rule_types = self.strategy.run(self.ticker_df.copy(), indicators_thread_safe_obj, {**trader_run_info, **trader_run_iteration_data})
    * This result should be correct
    * This result should be recorded in db correctly
    * This result should be then interpreted well to create or not to create an order.
* Ticker Data
  * Do not use timestamp but use datetime; rename field overall.
* In Backtests in bulk insert, you cannot get ticker_data_id and insert it into the trade session lines. So leave it null for now.
* smtrader-ui: Visualize whole backtest results; with ticker data, bolinger bands, SMAs, Signals. If you clieck a point, it shows more indicator data and rulle results etc.
* 

