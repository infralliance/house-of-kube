#!/bin/bash
# Auto-fixed by House of Kube batch
# Usage: ./create-namespace.sh <name> [namespace]

[ -z "$1" ] && echo "Usage: ./create-namespace.sh <name> [namespace]" && exit 1
NAME="$1"
NS="${2:-default}"

kubectl create namespace "$NAME" --dry-run=client -o yaml | kubectl apply -f -
