#!/bin/bash
# Auto-patched for House of Kube
# Usage: ./create-pod.sh <name> [namespace]

[ -z "$1" ] && echo "Usage: ./create-pod.sh <name> [namespace]" && exit 1
NAME="$1"
NS="${2:-default}"

kubectl run "$NAME" --image=nginx --restart=Never --dry-run=client -n "$NS" -o yaml | kubectl apply -f -
