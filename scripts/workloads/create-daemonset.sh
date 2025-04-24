#!/bin/bash
# Create a DaemonSet from user input
# Usage: ./create-daemonset.sh <name> [namespace]

set -e

[ -z "$1" ] && echo "Usage: $0 <name> [namespace]" && exit 1

NAME="$1"
NAMESPACE="${2:-default}"

read -p "🐳 Enter the container image (e.g. 'nginx'): " IMAGE
read -p "📥 Enter the command to run (optional): " CMD

CMD_BLOCK=""
if [ -n "$CMD" ]; then
  CMD_BLOCK="command: [\"/bin/sh\", \"-c\", \"$CMD\"]"
fi

cat <<EOF | kubectl apply -f -
apiVersion: apps/v1
kind: DaemonSet
metadata:
  name: $NAME
  namespace: $NAMESPACE
spec:
  selector:
    matchLabels:
      app: $NAME
  template:
    metadata:
      labels:
        app: $NAME
    spec:
      containers:
      - name: $NAME
        image: $IMAGE
        $CMD_BLOCK
EOF

echo "✅ DaemonSet '$NAME' created in namespace '$NAMESPACE' with image '$IMAGE'"

