#!/bin/bash
# Auto-patched for House of Kube
# Usage: ./create-mutatingwebhookconfiguration.sh <name> [namespace]

[ -z "$1" ] && echo "Usage: ./create-mutatingwebhookconfiguration.sh <name> [namespace]" && exit 1
NAME="$1"
NS="${2:-default}"

echo "⚠️ Webhook configs require YAML manifests. Skipping." && exit 0
