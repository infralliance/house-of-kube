#!/bin/bash
# Usage: ./create-verticalpodautoscaler.sh <name> <targetResource> <containerName>

set -e

if [ $# -lt 3 ]; then
  echo "Usage: $0 <vpa-name> <target-resource-name> <container-name>"
  exit 1
fi

VPA_NAME="$1"
TARGET="$2"
CONTAINER="$3"

cat <<EOF | kubectl apply -f -
apiVersion: autoscaling.k8s.io/v1
kind: VerticalPodAutoscaler
metadata:
  name: $VPA_NAME
spec:
  targetRef:
    apiVersion: "apps/v1"
    kind: Deployment
    name: $TARGET
  updatePolicy:
    updateMode: "Auto"
  resourcePolicy:
    containerPolicies:
    - containerName: $CONTAINER
      minAllowed:
        cpu: 100m
        memory: 128Mi
      maxAllowed:
        cpu: 1
        memory: 1Gi
EOF
