#!/bin/bash
# Auto-patched for House of Kube
# Usage: ./create-networkpolicy.sh <name> [namespace]

[ -z "$1" ] && echo "Usage: ./create-networkpolicy.sh <name> [namespace]" && exit 1
NAME="$1"
NS="${2:-default}"

kubectl create networkpolicy "$NAME" --pod-selector=app=demo --policy-types=Ingress --dry-run=client -n "$NS" -o yaml | kubectl apply -f -
