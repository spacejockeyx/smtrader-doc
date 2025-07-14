# Tasks

* smtrader-bot: indicators calculator
* smtrader-bot: Create real trader from simulated trader. Modes: BACKTEST, REAL

## Trader Flow
* Start ``ticker`` with ``timer``.
  * Run tick() every Minute:
    * Load `historical stock data` with time window of max. ``2 hours``.
      * If historical data exist in memory 
        * use from ``memory``.
      * If not
        * request from ``broker``.
    * Validate ``historical stock data``
      * If not valid, return.
    * Get ``latest stock data``
    * Validate ``latest stock data``
      * If not valid, return.
    * Add ``latest stock data`` to ``historical stock data``
    * Load ``indicator classes``
    * Calculate ``indicators`` - layered multithread
    * Calculate ``rules`` - layered multithread
    * Set ``initial budget`` and ``current budget`` of strategy; at first equal to each other.
    * Set ``Current PnL``; at first 0.
    * Load ``strategy``
    * Run ``strategy``
      * Calculate ``position`` (``+`` or ``0``). In first phases, I'll not have betting , so no ``-``.
      * Calculate score from ``rules`` (``buy`` or ``sell`` depending on ``position``)
        * Note: Every rule will have weight. I'll calculate the total score from their weights and use it for deciding for the signal.
      * If eligible (score is above treshold): 
        * Create ``signal`` (``BUY``, ``SELL``, ``PARTIAL_SELL``).
        * Note: In first phases, I'll work with single BUY (with all budget) and partial or full SELL.
    * If ``signal`` created, create ``order``.
      * Send ``order`` to ``broker``.
      * If response from ``order`` is successful:
        * Extract from response:
          * real ``buy or sell price`` from repsonse
        * Insert ``order`` into ``db``
        * Update ``position`` of strategy - on ``PARTIAL SELL`` do it on the last SELL.
        * Update ``current budget`` of strategy.
        * Update ``Current PnL`` of strategy.
      * Send ``email`` to myself.
    * return.
