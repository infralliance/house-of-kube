#!/bin/bash
# Auto-patched for House of Kube
# Usage: ./create-poddisruptionbudget.sh <name> <minAvailable> <labelKey=labelValue> [namespace]

set -e

if [ $# -lt 3 ]; then
  echo "Usage: $0 <name> <minAvailable> <labelKey=labelValue> [namespace]"
  exit 1
fi

NAME="$1"
MIN_AVAILABLE="$2"
LABEL="$3"
NS="${4:-default}"

LABEL_KEY="${LABEL%%=*}"
LABEL_VALUE="${LABEL#*=}"

cat <<EOF | kubectl apply -n "$NS" -f -
apiVersion: policy/v1
kind: PodDisruptionBudget
metadata:
  name: $NAME
spec:
  minAvailable: $MIN_AVAILABLE
  selector:
    matchLabels:
      $LABEL_KEY: $LABEL_VALUE
EOF
