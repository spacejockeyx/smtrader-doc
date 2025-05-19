# smtrader-data

This microservice runs a PostgreSQL database with two schemas:

- `backtest`: stores historical trade signals and backtest results.
- `trader`: stores live order and trade data.

## Folder Structure

smtrader-data/
├── Dockerfile
├── init-db.sh
├── requirements.txt
├── README.md
├── sql/
│   ├── create_schemas.sql
│   ├── create_backtest_tables.sql
│   └── create_trader_tables.sql

## Usage

1. Build and run the Docker container:

```bash

docker build -t smtrader-data .

docker run -p 5432:5432 \
  -v /path/on/host/postgres-data:/var/lib/postgresql/data \
  smtrader-data
  
# Replace /path/on/host/postgres-data with the directory path on your machine where you want data persisted.

````

2. Connect using:

    Host: localhost    
    Port: 5432    
    User: smtrader    
    Password: smtraderpass    
    Database: smtraderdb

## Update smtrader-infra Kubernetes Deployment for smtrader-data

Add a PersistentVolumeClaim (PVC) and mount it into the pod.

Example snippet for your smtrader-data deployment manifest (smtrader-data-deployment.yaml):

```yaml 

apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: smtrader-data-pvc
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 10Gi
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: smtrader-data
spec:
  replicas: 1
  selector:
    matchLabels:
      app: smtrader-data
  template:
    metadata:
      labels:
        app: smtrader-data
    spec:
      containers:
      - name: smtrader-data
        image: smtrader-data:latest
        ports:
        - containerPort: 5432
        volumeMounts:
        - name: smtrader-data-storage
          mountPath: /var/lib/postgresql/data
      volumes:
      - name: smtrader-data-storage
        persistentVolumeClaim:
          claimName: smtrader-data-pvc
```


## Summary

    When running locally with Docker: mount host folder to /var/lib/postgresql/data.

    When running on Kubernetes: use a PersistentVolumeClaim and mount it to /var/lib/postgresql/data.

    Keep all DB init scripts and Dockerfile as-is.