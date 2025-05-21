#!/bin/bash
set -e

echo "Starting local deployment with kustomize..."

kubectl apply -k ../k8s/overlays/local