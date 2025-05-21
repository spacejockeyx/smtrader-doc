#!/bin/bash
set -e

echo "Creating EKS cluster with eksctl..."
eksctl create cluster --name smtrader-cluster --region us-west-2 --nodes 2 --managed
