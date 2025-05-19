#!/bin/bash
echo "🧹 Tearing down all services..."

kubectl delete -f ../manifests/
kubectl delete -f ../volumes/local-pv.yaml
