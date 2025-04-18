#!/bin/bash
# Usage: ./create-endpointslice.sh <name> <ip> <port> <protocol>

set -e

if [ $# -lt 4 ]; then
  echo "Usage: $0 <name> <ip> <port> <protocol>"
  exit 1
fi

NAME="$1"
IP="$2"
PORT="$3"
PROTO="$4"

cat <<EOF | kubectl apply -f -
apiVersion: discovery.k8s.io/v1
kind: EndpointSlice
metadata:
  name: $NAME
  labels:
    kubernetes.io/service-name: $NAME
addressType: IPv4
endpoints:
  - addresses: ["$IP"]
ports:
  - name: web
    protocol: $PROTO
    port: $PORT
EOF
