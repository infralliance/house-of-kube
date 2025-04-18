#!/bin/bash
# Auto-fixed by House of Kube batch
# Usage: ./create-deployment.sh <name> [namespace]

[ -z "$1" ] && echo "Usage: ./create-deployment.sh <name> [namespace]" && exit 1
NAME="$1"
NS="${2:-default}"

kubectl create deployment "$NAME" --image=nginx --dry-run=client -n "$NS" -o yaml | kubectl apply -f -
