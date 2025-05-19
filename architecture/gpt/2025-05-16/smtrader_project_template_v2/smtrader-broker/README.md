# smtrader-broker

Microservice running IBKR Gateway and a Python API to manage it.

This microservice will:

    Run the IBKR Gateway application

    Provide a Python API wrapper to interact with the IBKR Gateway for:

        Starting/stopping IBKR Gateway

        Sending commands (e.g., connect, disconnect)

        Monitoring status

# Folder Structure

````
smtrader-broker/
├── api/
│   ├── main.py
│   ├── ibkr_client.py
│   └── requirements.txt
├── docker/
│   └── Dockerfile
├── README.md
└── scripts/
    └── start_ibkr_gateway.sh
````

## Running locally

```bash
docker build -t smtrader-broker ./docker
docker run -p 8000:8000 smtrader-broker
```
Then access the API:

    POST /connect with JSON {"username":"myuser", "password":"mypassword"}

    POST /disconnect

    GET /status

Notes

    You need to add the IBKR Gateway installation files in docker/ibgateway or adjust the Dockerfile accordingly.

    The start_ibkr_gateway.sh script must be customized with your actual IBKR Gateway startup commands.
