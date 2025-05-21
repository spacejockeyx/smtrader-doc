#!/bin/bash
set -e

echo "Starting production deployment..."

kubectl apply -k ../k8s/overlays/prod


