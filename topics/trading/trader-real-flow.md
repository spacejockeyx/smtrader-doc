## Trader Real Flow
* Start ``ticker`` with ``timer``.
  * Run tick() every Minute:
    * Load `historical stock data` with time window of max. ``2 hours``.
      * If historical data exist in memory 
        * use from ``memory``.
      * If not
        * from ``DB``
        * If not
          * request from ``broker``.
    * Validate ``historical stock data``
      * If not valid, log.
      * There should be also enough tick data to run strategy, if not, log and return.
        * Enough tick means: Until a threshold of missing ticks, it's acceptable to evaluate the rules; rules should be designed to work with last tick data entries, not last minutes. 
    * Get ``latest stock data`` from broker
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
      * Notes:
        * My single ``trader-bot`` instance runs: 
          * Only 1 strategy. A ``strategy`` handles:
            * Only 1 stock ``symbol``:
            * Trades via only 1 ```broker``` (in first phases of my project ``Interactive Brokers (IBKR)``)
        * A ``strategy`` evaluates multiple rules of types:
          * Basic treshold checks for a meaningful subset of the indicators.
          * PnL checks for ``Stop-Loss and Take-Profit``
          * PnL checks for ``Circuit Breakers``
          * Instant buy decision makers just in the beginning of the day in the first 15 min.
        * The rules are always considering ``whether it's worth it to buy or sell`` bz taking the below into account on calculating possible ``PnL`` on a possible ``signal``:
          * ``brokerage commissions`` 
          * ``exchange fees`` 
          * ``any other transaction costs``        
      * Calculate ``position`` (``+`` or ``0``). In first phases, I'll not have betting , so no ``-``.
      * Calculate score from ``rules`` (``buy`` or ``sell`` depending on ``position``)
        * Note: Every rule will have weight. I'll calculate the total score from their weights and use it for deciding for the signal.
      * If eligible (score is above treshold): 
        * Create ``signal`` (``BUY``, ``SELL``, ``PARTIAL_SELL``).
        * Note: In first phases, I'll work with single BUY (with all budget) and partial or full SELL.
    * If ``signal`` created, create ``order``.
      * Add order into queue
        * Any order has ``time to live (TTL)`` of 30 sec. - or shorter if decided.
        * If ``TTL`` is reached, the order should be automatically EXPIRED
          * Before disposing it, insert EXPIRED orders also into ``DB`` for logging, tracking and future analysis purposes. 
      * In ``Order Management`` consume the queue in parallel. If new order comes:
        * Send ``order`` to ``broker`` (at first I'll work with ``Interactive Brokers (IBKR)``). The ``order`` in queue stays but busy.
          * I'll use the type ``limit order`` instead of ``market order`` in the first phases.
            * Take a look later: So, I'll need logic to handle un-filled limit orders (e.g., cancel/replace after some time).
              * Partial Fills: What if a limit order is only partially filled? The Order Management needs to update the filled quantity, calculate costs/PnL for the filled portion, and potentially resubmit the remainder of the order or cancel it.
              * Cancel/Replace Logic: How quickly do you cancel and replace? What price do you use for the new limit order? This becomes a mini-strategy within Order Management.
              * Order ID Tracking: For cancel/replace, you'll need to track the original order ID and the new one.
        * Begin listening to ``order`` from ``IBKR`` (probably in socket connection for ``IBKR``)
          * Note:
            * This listening should be ideally completed under 30 sec.. Because my trading works with 1 min. intervals.
            * In case the broker responds too late  - bigger than 1 min., my logic should stop trading until it gets the last order's status successfully.
            * It means, it could be, that in the next minute(s):
              * no new order is allowed to be created.
              * but the strategy should be evaluated and new signal(s) should be created as normal.
              * From that reason, I need a parallel order listener in a separate order management for Interactive Brockers for fullfilling the above tasks.
                * ``"single active order policy"``: If it has a task for listening for a specific order, it does not accept any other order. So, it should consume a queue.
          * If ``order`` successful:
            * Remove ``order`` from queue.
            * Extract from response:
              * real ``buy or sell price`` from response
            * Insert ``order`` into ``db`` with details and status.
            * Update ``position`` of strategy - on ``PARTIAL SELL`` do it on the last SELL.
            * Update ``current budget`` of strategy.
            * Update ``current PnL`` of strategy.
               * Consider the ``brokerage commissions, exchange fees, and any other transaction costs``
            * Save all this info in ```DB```; in case the ``trader-bot`` stops and re-starts, load status from ``DB``.
              * Current position (shares held for the symbol).
              * The last known current budget and Current PnL.
              * The state of any pending orders in the queue or with the broker that haven't reached a final status (FILLED, CANCELED, REJECTED, EXPIRED). The Order Management component would need to reconcile these upon restart.
          * If ``order`` {not successful, internal error in ``IBKR``}:
            * Remove ``order`` from queue.
            * Extract from response:
              * Real reason and HTTP code for unsuccess.
            * Insert ``order`` into ``db`` with details and status.
            * No update on strategy.
          * If ``order`` - timeout on sending to ``IBKR``:
            * Retry: 3 times - but totally less than 30 sec.
          * If ``order`` - timeout on getting response from ``IBKR``:
            * Stay listening for 30 sec. 
            * If it does not responds (``Unknown Order State`` problem): 
              * do not allow any new order creation.
              * The strategy can work in parallel, create signals and add orders into the queue.
                * Any order has ``TTL`` of 30 sec. - or shorter if decided. So it's safe that they will be automatically EXPIRED.
              * Design a manual mechanism for researching the ``Unknown Order State``.
                * You will get notified by the email for this issue.
                * You should check the IBKR UI
                * If needed, you should contact IBKR support.
                * You could automatically create a support ticket at IBKR then an automation to follow it and notification from it...
                * If the problem is solved, call ``smtrader-bot-api`` to remove the ``order blocking``; manually or in an automation - will be decided.
      * Send ``email`` to myself: About the signal, order and order status; includes crucial details like symbol, quantity, price, timestamp, and the specific status.
    * return.
