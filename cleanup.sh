#!/bin/bash
# cleanup.sh — Delete all demo resources created by run-all-create-scripts.sh
# Namespace is optional (defaults to 'test')

NAMESPACE="${1:-test}"
echo "🧹 Cleaning up resources in namespace: $NAMESPACE"
echo "----------------------------------------"

kubectl delete all --all -n "$NAMESPACE"
kubectl delete namespace "$NAMESPACE" --ignore-not-found

echo "✅ Cleanup completed for namespace: $NAMESPACE"
