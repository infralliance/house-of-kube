#!/bin/bash
# Usage: ./create-ingress-class.sh [class-name]

CLASS_NAME="${1:-nginx}"

cat <<EOF | kubectl apply -f -
apiVersion: networking.k8s.io/v1
kind: IngressClass
metadata:
  name: $CLASS_NAME
spec:
  controller: k8s.io/ingress-nginx
EOF
