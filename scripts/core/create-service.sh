#!/bin/bash
# Auto-fixed by House of Kube batch
# Usage: ./create-service.sh <name> [namespace]

[ -z "$1" ] && echo "Usage: ./create-service.sh <name> [namespace]" && exit 1
NAME="$1"
NS="${2:-default}"

kubectl create service clusterip "$NAME" --tcp=80:80 --dry-run=client -n "$NS" -o yaml | kubectl apply -f -
