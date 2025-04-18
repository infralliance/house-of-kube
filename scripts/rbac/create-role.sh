#!/bin/bash
# Auto-fixed by House of Kube batch
# Usage: ./create-role.sh <name> [namespace]

[ -z "$1" ] && echo "Usage: ./create-role.sh <name> [namespace]" && exit 1
NAME="$1"
NS="${2:-default}"

kubectl create role "$NAME" --verb=get,list --resource=pods --dry-run=client -n "$NS" -o yaml | kubectl apply -f -
