# Budget Management in Executer

## Example

* Executer Starts:
  * Initial State
    * Budget Total = 4000
    * Portfolio = {"META", "AMZN"}
      * Prices = {"META": 250, "AMZN": 150}
  * Starts Bots:
    * Bot1
      * Initial Trader State
        * Symbol = "META"
        * Initial Budget = 2500
        * Trader Status: Monitoring For Buy
      * Ticker Loop
        * Ticker 001:
          * Trader State
            * Current Budget = 2500
            * Trader Status: Monitoring For Buy
        * Ticker 002:
          * Trader State
            * Current Budget = 2500
            * Trader Status: Monitoring For Buy
          * Signal: BUY
            * Price: 255          
          * Current Budget Check:            
            * Quantity = 2500 / 255 = 9.8 (can buy 9 full shares)
            * Required Budget = 9 * 255 = 2295
            * Current Budget = 2500
            * 2295 <= 2500  �� Sufficient Budget
            * Decision: Proceed with BUY            
          * Execute Trade:
            * Trade Type: BUY
            * Quantity: 9
            * Price: 255
            * Total Cost: 2295
            * Update Budget: 2500 - 2295 = 205
            * Update Portfolio: {"META": 9 shares}
            * Log Trade: Recorded BUY of 9 META at 255
            * Insert Trade Log 
            * Post-Trade State:
              * See the next Ticker
        * Ticker 003:
          * Trader State
            * Current Budget = 205
            * Trader Status: In Position (Monitoring For Sell)
            * Position = 9
        * Ticker 004:
          * Trader State
            * Current Budget = 205
            * Trader Status: In Position (Monitoring For Sell)
            * Position = 9
          * Signal: SELL
            * Price: 260
          * Position Check:
            * Current Position = 9
            * Required Position = 9
            * 9 >= 9  �� Sufficient Position
            * Decision: Proceed with SELL
          * Execute Trade:
            * Trade Type: SELL
            * Quantity: 9
            * Price: 260
            * Total Proceeds: 9 * 260 = 2340
            * Update Budget: 205 + 2340 = 2545
            * Update Portfolio: {"META": 0 shares}
            * Log Trade: Recorded SELL of 9 META at 260
            * Insert Trade Log 
            * Post-Trade State:
              * See the next Ticker
        * Ticker 005:
          * Trader State
            * Current Budget = 2545
            * Trader Status: Monitoring For Buy
        * Ticker 006:
        * Ticker 007:
        * Ticker 008:
        * Ticker 009:
        * Ticker 010:
        * Ticker 011:
        * Ticker 012:
        * Ticker 013:
        * Ticker 014:
        * Ticker 015:
        * Ticker 016:
        * Ticker 017:
        * Ticker 018:
        * Ticker 019:
        * Ticker 020:
        * Ticker 021:
        * Ticker 022:
        * Ticker 023:
        * Ticker 024:
        * Ticker 025:
        * Ticker 026:
        * Ticker 027:
        * Ticker 028:
        * Ticker 029:
        * Ticker 030:        
    * Bot2
      * Initial State
        * Symbol = "AMZN"
        * Budget = 1500
      * Ticker Loop
        * Ticker 001:
        * Ticker 002:
        * Ticker 003:
        * Ticker 004:
        * Ticker 005:
        * Ticker 006:
        * Ticker 007:
        * Ticker 008:
        * Ticker 009:
        * Ticker 010:
        * Ticker 011:
        * Ticker 012:
        * Ticker 013:
        * Ticker 014:
        * Ticker 015:
        * Ticker 016:
        * Ticker 017:
        * Ticker 018:
        * Ticker 019:
        * Ticker 020:
        * Ticker 021:
        * Ticker 022:
        * Ticker 023:
        * Ticker 024:
        * Ticker 025:
        * Ticker 026:
        * Ticker 027:
        * Ticker 028:
        * Ticker 029:
        * Ticker 030: