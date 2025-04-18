#!/bin/bash
# Auto-fixed by House of Kube batch
# Usage: ./create-clusterrolebinding.sh <name> [namespace]

[ -z "$1" ] && echo "Usage: ./create-clusterrolebinding.sh <name> [namespace]" && exit 1
NAME="$1"
NS="${2:-default}"

kubectl create rolebinding "$NAME" --role=admin --user=dev --dry-run=client -n "$NS" -o yaml | kubectl apply -f -
