#!/bin/bash
# create-horizontalpodautoscaler.sh - Interactive HorizontalPodAutoscaler creator by House of Kube

set -e

# Prompt for deployment name
if [ -z "$1" ]; then
  read -p "📝 Enter the Deployment name: " DEPLOYMENT_NAME
else
  DEPLOYMENT_NAME="$1"
fi

# Prompt for namespace
if [ -z "$2" ]; then
  read -p "📦 Enter namespace (default: default): " NAMESPACE
  NAMESPACE="${NAMESPACE:-default}"
else
  NAMESPACE="$2"
fi

# Ask for minimum and maximum replicas
read -p "🔢 Enter the minimum number of replicas (default: 1): " MIN_REPLICAS
MIN_REPLICAS="${MIN_REPLICAS:-1}"

read -p "🔢 Enter the maximum number of replicas (default: 3): " MAX_REPLICAS
MAX_REPLICAS="${MAX_REPLICAS:-3}"

# Ask for CPU utilization target
read -p "📊 Enter the target CPU utilization percentage (default: 50): " CPU_TARGET
CPU_TARGET="${CPU_TARGET:-50}"

# Generate and apply the HorizontalPodAutoscaler YAML
cat <<EOF | kubectl apply -f -
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: $DEPLOYMENT_NAME
  namespace: $NAMESPACE
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: $DEPLOYMENT_NAME
  minReplicas: $MIN_REPLICAS
  maxReplicas: $MAX_REPLICAS
  metrics:
  - type: Resource
    resource:
      name: cpu
      target:
        type: Utilization
        averageUtilization: $CPU_TARGET
EOF

echo "✅ HorizontalPodAutoscaler created successfully for Deployment '$DEPLOYMENT_NAME' in namespace '$NAMESPACE'."

