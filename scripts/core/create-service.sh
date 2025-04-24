#!/bin/bash
# Auto-fixed by House of Kube batch
# Usage: ./create-service.sh <name> [namespace]

# Vérifier les arguments
if [ -z "$1" ]; then
  echo "Usage: ./create-service.sh <name> [namespace]"
  exit 1
fi

NAME="$1"
NS="${2:-default}"

# Demander à l'utilisateur quel type d'objet il souhaite exposer
echo "What object would you like to expose with the service?"
echo "   1) Pod"
echo "   2) Deployment"
echo -n "Select an option (1-2): "
read object_type

# Demander le nom de l'objet à exposer
case "$object_type" in
  1)
    echo -n "Enter the Pod name: "
    read object_name
    ;;
  2)
    echo -n "Enter the Deployment name: "
    read object_name
    ;;
  *)
    echo "Invalid option. Exiting."
    exit 1
    ;;
esac

# Demander à l'utilisateur quel type de service il souhaite créer
echo "Choose the type of service:"
echo "   1) ClusterIP (default)"
echo "   2) NodePort"
echo "   3) LoadBalancer"
echo -n "Select an option (1-3): "
read service_type

# Définir le type de service en fonction du choix
case "$service_type" in
  1)
    SERVICE_TYPE="ClusterIP"
    ;;
  2)
    SERVICE_TYPE="NodePort"
    ;;
  3)
    SERVICE_TYPE="LoadBalancer"
    ;;
  *)
    echo "Invalid option. Using default type 'ClusterIP'."
    SERVICE_TYPE="ClusterIP"
    ;;
esac

# Demander à l'utilisateur de spécifier les ports
echo -n "Enter the port to expose (e.g., '80:80'): "
read ports

# Vérifier que les ports sont valides
if [ -z "$ports" ]; then
  echo "Invalid ports provided."
  exit 1
fi

# Extraire les ports à partir de l'entrée utilisateur
IFS=':' read -r port_name port_target <<< "$ports"

# Exposer l'objet en fonction du type choisi
case "$object_type" in
  1)
    echo "Exposing Pod $object_name with service $SERVICE_TYPE."
    kubectl expose pod "$object_name" --name="$NAME" --type="$SERVICE_TYPE" --port="$port_name" --target-port="$port_target" -n "$NS" --dry-run=client -o yaml | kubectl apply -f -
    ;;
  2)
    echo "Exposing Deployment $object_name with service $SERVICE_TYPE."
    kubectl expose deployment "$object_name" --name="$NAME" --type="$SERVICE_TYPE" --port="$port_name" --target-port="$port_target" -n "$NS" --dry-run=client -o yaml | kubectl apply -f -
    ;;
  *)
    echo "Invalid object type. Exiting."
    exit 1
    ;;
esac
