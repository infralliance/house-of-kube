#!/bin/bash
# Usage: ./create-endpointslice.sh <name> <ip> <port> <protocol> [<port-name>]

set -euo pipefail

if [ $# -lt 4 ]; then
  echo "Usage: $0 <name> <ip> <port> <protocol> [<port-name>]"
  exit 1
fi

NAME="$1"
IP="$2"
PORT="$3"
PROTO="$4"
PORT_NAME="${5:-web}"

# Vérification simple de l'IP (IPv4)
if ! [[ "$IP" =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
  echo "Erreur : adresse IP invalide."
  exit 1
fi

cat <<EOF | kubectl apply -f -
apiVersion: discovery.k8s.io/v1
kind: EndpointSlice
metadata:
  name: ${NAME}
  labels:
    kubernetes.io/service-name: ${NAME}
addressType: IPv4
endpoints:
  - addresses:
      - "${IP}"
ports:
  - name: "${PORT_NAME}"
    protocol: "${PROTO}"
    port: ${PORT}
EOF

