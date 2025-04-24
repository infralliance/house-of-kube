#!/bin/bash
# Auto-fixed by House of Kube batch
# Usage: ./create-serviceaccount.sh <name> [namespace]

# Check if name is provided
if [ -z "$1" ]; then
  echo "Usage: ./create-serviceaccount.sh <name> [namespace]"
  exit 1
fi

NAME="$1"
NS="${2:-default}"

# Create the ServiceAccount in the specified namespace
echo "Creating ServiceAccount '$NAME' in namespace '$NS'..."
kubectl create serviceaccount "$NAME" -n "$NS" --dry-run=client -o yaml | kubectl apply -f -
