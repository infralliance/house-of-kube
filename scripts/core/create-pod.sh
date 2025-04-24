#!/bin/bash
# Auto-patched for House of Kube
# Usage: ./create-pod.sh <name> [namespace]

[ -z "$1" ] && echo "Usage: ./create-pod.sh <name> [namespace]" && exit 1
NAME="$1"
NS="${2:-default}"

read -p "📦 Docker image (e.g., nginx, busybox) [default: nginx]: " IMAGE
IMAGE=${IMAGE:-nginx}

read -p "🚀 Command to run (leave empty for default entrypoint): " CMD

read -p "💾 Volume mount path (inside container, optional): " VOLUME_MOUNT_PATH

# Generate and apply the pod manifest
cat <<EOF | kubectl apply -n "$NS" -f -
apiVersion: v1
kind: Pod
metadata:
  name: $NAME
spec:
  containers:
  - name: $NAME
    image: $IMAGE
    $( [ -n "$CMD" ] && echo "command: [\"$CMD\"]" )
    $( [ -n "$VOLUME_MOUNT_PATH" ] && echo "volumeMounts:\n    - mountPath: $VOLUME_MOUNT_PATH\n      name: vol1" )
  $( [ -n "$VOLUME_MOUNT_PATH" ] && echo "volumes:\n  - name: vol1\n    emptyDir: {}" )
  restartPolicy: Never
EOF
