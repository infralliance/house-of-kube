#!/bin/bash
# Auto-patched for House of Kube
# Usage: ./create-ingress.sh <name> [namespace]

[ -z "$1" ] && echo "Usage: ./create-ingress.sh <name> [namespace]" && exit 1
NAME="$1"
NS="${2:-default}"

kubectl create ingress "$NAME" --rule="example.com/*=service:80" --dry-run=client -n "$NS" -o yaml | kubectl apply -f -
