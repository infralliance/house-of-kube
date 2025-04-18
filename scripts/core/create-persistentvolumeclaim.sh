#!/bin/bash
# Auto-patched for House of Kube
# Usage: ./create-persistentvolumeclaim.sh <name> [namespace]

[ -z "$1" ] && echo "Usage: ./create-persistentvolumeclaim.sh <name> [namespace]" && exit 1
NAME="$1"
NS="${2:-default}"

kubectl create pvc "$NAME" --access-modes=ReadWriteOnce --resources=requests.storage=1Gi --dry-run=client -n "$NS" -o yaml | kubectl apply -f -
