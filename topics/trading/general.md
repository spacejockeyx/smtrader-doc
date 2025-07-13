# Ideas

## Partial Buy

* It must be done in separate bots if needed.
* The bot instances for the same Symbol must be somehow in communication.
  * For the same minute only one of them is allowed to buy.
  * The other one then should try to buy from the next minute on.
* Argument against partial buy:
  * E.g.:
    * You buy for prize 10 and 14
    * Then it sinks to 8 and you couldn't sell because of a defect.
    * Then it increases to 12.
      * What would you do? Sell? Or not yet? Because you have 2 different buy prices; 10 & 14.
        * If you wait for increase over 14, you miss the opportunity with 12to10.
        * If you sell for 12, you are doing partially neagtive PnL with 12to14.
    * So, don't do partial buy in same bot instance.
    * But, partial say should be ok.
