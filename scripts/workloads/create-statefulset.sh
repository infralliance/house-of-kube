#!/bin/bash
# Auto-patched for House of Kube
# Usage: ./create-statefulset.sh <name> [namespace]
# Level: easy

# Vérification des arguments
[ -z "$1" ] && echo "Usage: ./create-statefulset.sh <name> [namespace]" && exit 1
NAME="$1"
NS="${2:-default}"

# Demander des informations sur l'image
read -p "🐳 Enter the container image (default: 'nginx'): " IMAGE
IMAGE="${IMAGE:-nginx}"

# Demander la commande à exécuter (optionnelle)
read -p "📥 Enter the command to run (optional, default: none): " CMD
if [ -z "$CMD" ]; then
  echo "ℹ️  No command provided, using default entrypoint from image."
else
  echo "ℹ️  Using custom command: $CMD"
fi

# Demander des informations supplémentaires sur le StatefulSet (par exemple, réplicas)
read -p "🔢 Enter the number of replicas (default: 1): " REPLICAS
REPLICAS="${REPLICAS:-1}"

# Demander si l'image doit exposer un port et, si oui, quel port
read -p "🔌 Do you want to expose a port? (default: no) [y/N]: " EXPOSE_PORT
EXPOSE_PORT="${EXPOSE_PORT:-n}"

if [[ "$EXPOSE_PORT" =~ ^[Yy]$ ]]; then
  read -p "⚙️ Enter the container port to expose: " CONTAINER_PORT
  CONTAINER_PORT="${CONTAINER_PORT:-80}"
  PORTS_SECTION="        ports:
        - containerPort: $CONTAINER_PORT"
else
  PORTS_SECTION=""
fi

# Générer un fichier YAML temporaire pour le StatefulSet
cat <<EOF > /tmp/statefulset.yaml
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: $NAME
  namespace: $NS
spec:
  replicas: $REPLICAS
  selector:
    matchLabels:
      app: $NAME
  serviceName: "$NAME"
  template:
    metadata:
      labels:
        app: $NAME
    spec:
      containers:
      - name: $NAME
        image: $IMAGE
        command: ["/bin/sh", "-c", "$CMD"]
$PORTS_SECTION
  volumeClaimTemplates:
  - metadata:
      name: $NAME
    spec:
      accessModes: ["ReadWriteOnce"]
      resources:
        requests:
          storage: 1Gi
EOF

# Appliquer le YAML généré avec kubectl
kubectl apply -f /tmp/statefulset.yaml

# Supprimer le fichier YAML temporaire
rm /tmp/statefulset.yaml

echo "✅ StatefulSet '$NAME' created with $REPLICAS replicas in namespace '$NS'."
