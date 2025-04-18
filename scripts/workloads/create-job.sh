#!/bin/bash
# Auto-fixed by House of Kube batch
# Usage: ./create-job.sh <name> [namespace]

[ -z "$1" ] && echo "Usage: ./create-job.sh <name> [namespace]" && exit 1
NAME="$1"
NS="${2:-default}"

kubectl create job "$NAME" --image=busybox --dry-run=client -n "$NS" -o yaml | kubectl apply -f -
