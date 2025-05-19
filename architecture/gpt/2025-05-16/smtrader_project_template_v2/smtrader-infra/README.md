# smtrader-infra

This repository contains Kubernetes deployment infrastructure for the SMTrader microservices.

# Project Folder Layout (with local Dev with Minikube)
````text
smtrader-infra/
├── README.md
├── setup/
│   ├── init_minikube.sh
│   ├── deploy_all.sh
│   ├── teardown.sh
│   └── helpers/
│       └── wait-for-pods.sh
├── manifests/
│   ├── namespace.yaml
│   ├── smtrader-data.yaml
│   ├── smtrader-broker.yaml
│   ├── smtrader-ui.yaml
│   ├── smtrader-executer.yaml
│   └── smtrader-bot.yaml
└── volumes/
    └── local-pv.yaml

````


# Deployments

## smtrader-infra - Local Minikube Deployment

This repository also sets up and manages all services of the smtrader trading infrastructure locally using **Minikube** (Kubernetes). It mirrors the production deployment as closely as possible.

### Requirements

- Docker
- kubectl
- minikube

### How to Use

```bash
cd smtrader-infra/setup
./init_minikube.sh      # Starts Minikube with necessary configs
./deploy_all.sh         # Deploys all smtrader services
./teardown.sh           # Destroys all deployments and volumes

## How to Use

```bash
cd smtrader-infra/setup
./init_minikube.sh      # Starts Minikube with necessary configs
./deploy_all.sh         # Deploys all smtrader services
./teardown.sh           # Destroys all deployments and volumes

```