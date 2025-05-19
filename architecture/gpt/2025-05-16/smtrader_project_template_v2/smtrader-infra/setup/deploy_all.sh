#!/bin/bash
echo "🚀 Deploying smtrader microservices to Minikube..."

kubectl apply -f ../manifests/smtrader-data.yaml
kubectl apply -f ../manifests/smtrader-broker.yaml
kubectl apply -f ../manifests/smtrader-executer.yaml
kubectl apply -f ../manifests/smtrader-bot.yaml
kubectl apply -f ../manifests/smtrader-ui.yaml
