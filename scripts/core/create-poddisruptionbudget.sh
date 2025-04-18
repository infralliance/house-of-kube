#!/bin/bash
# Usage: ./create-poddisruptionbudget.sh <name> <minAvailable> <labelKey=labelValue>

set -e

if [ $# -lt 3 ]; then
  echo "Usage: $0 <name> <minAvailable> <labelKey=labelValue>"
  exit 1
fi

NAME="$1"
MIN_AVAILABLE="$2"
LABEL="$3"

kubectl create pdb "$NAME" \
  --min-available="$MIN_AVAILABLE" \
  --selector="$LABEL" \
  --dry-run=client -o yaml | kubectl apply -f -
