#!/bin/bash

# Persistent volumes are defined in volumes/local-pv.yaml. These mount to your local disk (under ~/smtrader-volumes by default).

echo "🧩 Starting Minikube..."
minikube start --driver=docker

echo "📂 Creating volumes folder..."
mkdir -p ~/smtrader-volumes

echo "📦 Applying namespace..."
kubectl apply -f ../manifests/namespace.yaml

echo "📦 Applying local volume definitions..."
kubectl apply -f ../volumes/local-pv.yaml
