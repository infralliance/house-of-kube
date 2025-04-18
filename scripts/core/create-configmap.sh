#!/bin/bash
# Auto-fixed by House of Kube batch
# Usage: ./create-configmap.sh <name> [namespace]

[ -z "$1" ] && echo "Usage: ./create-configmap.sh <name> [namespace]" && exit 1
NAME="$1"
NS="${2:-default}"

kubectl create configmap "$NAME" --from-literal=key=value --dry-run=client -n "$NS" -o yaml | kubectl apply -f -
