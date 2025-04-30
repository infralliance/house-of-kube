#!/bin/bash
# create-verticalpodautoscaler.sh - Interactive VerticalPodAutoscaler creator by House of Kube

set -e

# Prompt for VPA name
if [ -z "$1" ]; then
  read -p "📝 Enter the VerticalPodAutoscaler name: " VPA_NAME
else
  VPA_NAME="$1"
fi

# Prompt for namespace
if [ -z "$2" ]; then
  read -p "📦 Enter namespace (default: default): " NAMESPACE
  NAMESPACE="${NAMESPACE:-default}"
else
  NAMESPACE="$2"
fi

# Prompt for target resource name
read -p "🔍 Enter the target resource name (e.g., Deployment name): " TARGET_RESOURCE_NAME

# Prompt for container name
read -p "📦 Enter the container name within the target resource: " CONTAINER_NAME

# Ask for CPU and memory limits
read -p "💾 Enter the minimum CPU limit for the container (default: 100m): " MIN_CPU
MIN_CPU="${MIN_CPU:-100m}"

read -p "💾 Enter the minimum memory limit for the container (default: 128Mi): " MIN_MEMORY
MIN_MEMORY="${MIN_MEMORY:-128Mi}"

read -p "💾 Enter the maximum CPU limit for the container (default: 1): " MAX_CPU
MAX_CPU="${MAX_CPU:-1}"

read -p "💾 Enter the maximum memory limit for the container (default: 1Gi): " MAX_MEMORY
MAX_MEMORY="${MAX_MEMORY:-1Gi}"

# Check that required values are provided
if [ -z "$VPA_NAME" ] || [ -z "$TARGET_RESOURCE_NAME" ] || [ -z "$CONTAINER_NAME" ]; then
  echo "❌ Error: VPA name, target resource name, and container name are required."
  exit 1
fi

# Generate and apply the VerticalPodAutoscaler YAML
echo "📝 Generating VerticalPodAutoscaler YAML for '$VPA_NAME'..."

cat <<EOF | kubectl apply -f -
apiVersion: autoscaling.k8s.io/v1
kind: VerticalPodAutoscaler
metadata:
  name: $VPA_NAME
  namespace: $NAMESPACE
spec:
  targetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: $TARGET_RESOURCE_NAME
  updatePolicy:
    updateMode: "Auto"
  resourcePolicy:
    containerPolicies:
    - containerName: $CONTAINER_NAME
      minAllowed:
        cpu: $MIN_CPU
        memory: $MIN_MEMORY
      maxAllowed:
        cpu: $MAX_CPU
        memory: $MAX_MEMORY
EOF

echo "✅ VerticalPodAutoscaler '$VPA_NAME' created successfully for Deployment '$TARGET_RESOURCE_NAME' in namespace '$NAMESPACE'."

