#!/bin/bash
# Auto-patched for House of Kube
# Usage: ./create-storageclass.sh <name> [namespace]

[ -z "$1" ] && echo "Usage: ./create-storageclass.sh <name> [namespace]" && exit 1
NAME="$1"
NS="${2:-default}"

echo "⚠️ StorageClass must be defined via manifest. Skipping." && exit 0
