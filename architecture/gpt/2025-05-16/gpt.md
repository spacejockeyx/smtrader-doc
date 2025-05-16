# 2025-05-16

## Q1

I created my microservice repositories like below for achieving successfull stock day-trading via InteractiveBrockers.

For creating scripts, IaC, UI elements etc. please use our agreed techstack before in this chat.

All the below nodes should be running in the same pod from my opinion.

Can you create a zip file below or put the code into a coomon place where I can easily download or clone?

### smtrader-infra

* Here, I'll add:
  * Kubernates setup for running the docker containers of the other component microservice repositories:
    * smtrader-data
    * smtrader-ui
    * smtrader-executer  
    * smtrader-broker
  * This Kubernates setup should be deoployable into a cloud server or Kubernates service like AWS Fargate as well as into my local computer in the same way as much as posibble.
* I need to be created:
  * All setup scripts and run scripts to be created.
  * If you have more to create, feel free to add.

### smtrader-ui

* This is the user interface microservice. It provides a Web UI there firstly I can list all my runnning nodes.
* There I should be able to send smtrader executer API commands via UI to let it manage the bot nodes.
* Additionally, I get infos from smtrader-executer about the total budget, profit, loss, orders aggregated from the nodes.
* Furthermore, I should be able to monitor the bot nodes for individual budget, profit, loss, orders etc,
* The UI should have connectivits to data (DB) node, as well.
* I need to be created:
  * Web Application that have connectivity to all the nodes below.

### smtrader-executer

* Process List:
  * `api`
  * `workflow`
    * This manages trader bots.
    * It should be able to programmatically (via python) create/destroy nodes for up/down scaling of my trader bots.

* I need to be created:
  * python `api`.
  * application `workflow` for managing the pods, budget, profit or loss, alarms etc. 
  * If you have more to create, feel free to add.

### smtrader-bot

* I've already created a bot application with python and ran it in my local.

* This application creates a timer. On every timer_tick() event 
  * It loads stock market ticker data from csv file.
  * Then it tries to create meaningful signals accoring to my strategy rules on every minute.

* So, this bot should always be up and running, as long as the node ``smtrader-executer`` allows it to be running (due to its workflow management).

* ``smtrader-executer``manages manages this bot node; it creates bot instance or destroys due to budget and profit criteria.

* Process List:
  * `api`
  * `trader`
  * `ordermanager`

* I need to be created:
  * dockerfile(s) that include and run python api and IBKR Gateway.
  * If you have more to create, feel free to add.

### smtrader-data

* Here, one database instance will be running with 2 schemas:
  * backtest
  * trader

* Process List:
  * `smtraderdb`
    * This is Postgres DB instance for my solution tha includes firtsly the schemas above mentioned.

* I need to be created:
  * dockerfile(s) that include and run database instance, schemas, basic trading and backtest tables creation SQL scripts to be created.
  * If you have more to create, feel free to add.

## smtrader-broker

* This is the node for InteractiveBorkers gateway.

* Process List:
  * `api`
  * `ibkrgateway`
    * IBKR GAteway application

* I need to be created:
  * dockerfile(s) that include and run python api and IBKR Gateway.
  * If you have more to create, feel free to add.



