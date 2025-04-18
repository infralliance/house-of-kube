#!/bin/bash
# Auto-patched for House of Kube
# Usage: ./create-persistentvolume.sh <name> [namespace]

[ -z "$1" ] && echo "Usage: ./create-persistentvolume.sh <name> [namespace]" && exit 1
NAME="$1"
NS="${2:-default}"

kubectl create pv "$NAME" --dry-run=client -o yaml | kubectl apply -f -
