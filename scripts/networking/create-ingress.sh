#!/bin/bash
# Usage: ./create-ingress.sh <name> <host> <service> <service-port> [namespace]

set -e

if [ $# -lt 4 ]; then
  echo "Usage: $0 <name> <host> <service> <service-port> [namespace]"
  exit 1
fi

NAME="$1"
HOST="$2"
SERVICE="$3"
PORT="$4"
NS="${5:-default}"

cat <<EOF | kubectl apply -f -
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: $NAME
  namespace: $NS
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
spec:
  rules:
  - host: $HOST
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: $SERVICE
            port:
              number: $PORT
EOF

