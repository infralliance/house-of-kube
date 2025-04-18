#!/bin/bash
# Auto-fixed by House of Kube batch
# Usage: ./create-secret.sh <name> [namespace]

[ -z "$1" ] && echo "Usage: ./create-secret.sh <name> [namespace]" && exit 1
NAME="$1"
NS="${2:-default}"

kubectl create secret generic "$NAME" --from-literal=password=secret --dry-run=client -n "$NS" -o yaml | kubectl apply -f -
