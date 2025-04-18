#!/bin/bash
# Auto-patched for House of Kube
# Usage: ./create-horizontalpodautoscaler.sh <name> [namespace]

[ -z "$1" ] && echo "Usage: ./create-horizontalpodautoscaler.sh <name> [namespace]" && exit 1
NAME="$1"
NS="${2:-default}"

kubectl autoscale deployment "$NAME" --cpu-percent=50 --min=1 --max=3 --dry-run=client -n "$NS" -o yaml | kubectl apply -f -
