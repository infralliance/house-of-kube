#!/bin/bash
# Create a Deployment from user input
# Usage: ./create-deployment.sh <name> [namespace]

set -e

[ -z "$1" ] && echo "Usage: $0 <name> [namespace]" && exit 1

NAME="$1"
NAMESPACE="${2:-default}"

read -p "🐳 Enter the container image (default: nginx): " IMAGE
IMAGE="${IMAGE:-nginx}"

kubectl create deployment "$NAME" --image="$IMAGE" --dry-run=client -n "$NAMESPACE" -o yaml | kubectl apply -f -

