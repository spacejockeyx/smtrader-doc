# smtrader-executer

## Overview
This microservice manages trader bots, handles scaling logic, and provides an API for orchestration and monitoring. It consists of two main components:
- `api`: REST API for orchestrating bots.
- `workflow`: Core logic to launch/terminate strategy runner pods.

## File Structure
```
smtrader-executer/
├── api/
│   └── main.py
├── workflow/
│   ├── __init__.py
│   └── manager.py
├── Dockerfile
├── requirements.txt
└── README.md
```

---

### `api/main.py`
```python
from fastapi import FastAPI, HTTPException
from workflow.manager import launch_bot, terminate_bot

app = FastAPI()

@app.get("/status")
def status():
    return {"executer": "running"}

@app.post("/scale")
def scale_bots(symbol: str, count: int):
    try:
        launch_bot(symbol, count)
        return {"message": f"Scaling {symbol} bots to {count}"}
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

@app.post("/terminate")
def terminate(symbol: str):
    try:
        terminate_bot(symbol)
        return {"message": f"Terminated all bots for {symbol}"}
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
```

---

### `workflow/manager.py`
```python
from kubernetes import client, config

config.load_kube_config()

def launch_bot(symbol: str, count: int = 1):
    print(f"Launching {count} bot(s) for {symbol}...")
    for i in range(count):
        name = f"bot-{symbol.lower()}-{i}"
        body = client.V1Pod(
            metadata=client.V1ObjectMeta(name=name),
            spec=client.V1PodSpec(containers=[
                client.V1Container(
                    name="trader-bot",
                    image="smtrader-bot:latest",
                    env=[client.V1EnvVar(name="SYMBOL", value=symbol)]
                )
            ])
        )
        v1 = client.CoreV1Api()
        v1.create_namespaced_pod(namespace="default", body=body)

def terminate_bot(symbol: str):
    v1 = client.CoreV1Api()
    pod_list = v1.list_namespaced_pod(namespace="default")
    for pod in pod_list.items:
        if symbol.lower() in pod.metadata.name:
            v1.delete_namespaced_pod(name=pod.metadata.name, namespace="default")
            print(f"Deleted pod: {pod.metadata.name}")
```

---

### `Dockerfile`
```Dockerfile
FROM python:3.10-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

CMD ["uvicorn", "api.main:app", "--host", "0.0.0.0", "--port", "8000"]
```

---

### `requirements.txt`
```
fastapi
uvicorn
kubernetes
```

---

### `README.md`
```
# smtrader-executer

This service manages bot lifecycles and orchestrates strategy nodes.

## Endpoints
- `GET /status` — Health check
- `POST /scale?symbol=XYZ&count=2` — Launch multiple bots
- `POST /terminate?symbol=XYZ` — Terminate all bots of given symbol
```
