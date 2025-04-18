#!/bin/bash
# Auto-patched for House of Kube
# Usage: ./create-replicaset.sh <name> [namespace]

[ -z "$1" ] && echo "Usage: ./create-replicaset.sh <name> [namespace]" && exit 1
NAME="$1"
NS="${2:-default}"

kubectl create deployment "$NAME" --image=nginx --replicas=3 --dry-run=client -n "$NS" -o yaml | kubectl apply -f -
