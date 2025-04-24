#!/bin/bash
# Auto-fixed by House of Kube batch
# Usage: ./create-configmap.sh <name> [namespace]

# Vérifier les arguments
if [ -z "$1" ]; then
  echo "Usage: ./create-configmap.sh <name> [namespace]"
  exit 1
fi

NAME="$1"
NS="${2:-default}"

echo "🔑 Choose how you want to create the configmap:"
echo "   1) From a directory (all files in the directory)"
echo "   2) From specific key-value files"
echo "   3) From literal key-value pairs"
echo "   4) From a key-value file"
echo "   5) From an env file"
echo -n "Select an option (1-5): "
read option

case "$option" in
  1)
    echo "You chose to create the configmap from a directory."
    echo -n "Enter the directory path: "
    read dir_path
    if [ -d "$dir_path" ]; then
      kubectl create configmap "$NAME" --from-file="$dir_path" -n "$NS" --dry-run=client -o yaml | kubectl apply -f -
    else
      echo "Directory does not exist."
      exit 1
    fi
    ;;
  2)
    echo "You chose to create the configmap from specific key-value files."
    config_entries=()
    while true; do
      echo -n "Enter key (or press Enter to stop): "
      read key
      if [ -z "$key" ]; then
        break
      fi
      echo -n "Enter the file path for '$key': "
      read file_path
      if [ -f "$file_path" ]; then
        config_entries+=("--from-file=$key=$file_path")
      else
        echo "File does not exist."
      fi
    done
    if [ ${#config_entries[@]} -gt 0 ]; then
      kubectl create configmap "$NAME" "${config_entries[@]}" -n "$NS" --dry-run=client -o yaml | kubectl apply -f -
    else
      echo "No valid key-file pairs provided."
      exit 1
    fi
    ;;
  3)
    echo "You chose to create the configmap from literal key-value pairs."
    config_entries=()
    while true; do
      echo -n "Enter key (or press Enter to stop): "
      read key
      if [ -z "$key" ]; then
        break
      fi
      echo -n "Enter the value for '$key': "
      read value
      config_entries+=("--from-literal=$key=$value")
    done
    if [ ${#config_entries[@]} -gt 0 ]; then
      kubectl create configmap "$NAME" "${config_entries[@]}" -n "$NS" --dry-run=client -o yaml | kubectl apply -f -
    else
      echo "No valid key-value pairs provided."
      exit 1
    fi
    ;;
  4)
    echo "You chose to create the configmap from a key-value file."
    echo -n "Enter the file path containing key-value pairs (key=value format): "
    read kv_file
    if [ -f "$kv_file" ]; then
      kubectl create configmap "$NAME" --from-file="$kv_file" -n "$NS" --dry-run=client -o yaml | kubectl apply -f -
    else
      echo "File does not exist."
      exit 1
    fi
    ;;
  5)
    echo "You chose to create the configmap from an env file."
    echo -n "Enter the env file path (key=value format): "
    read env_file
    if [ -f "$env_file" ]; then
      kubectl create configmap "$NAME" --from-env-file="$env_file" -n "$NS" --dry-run=client -o yaml | kubectl apply -f -
    else
      echo "File does not exist."
      exit 1
    fi
    ;;
  *)
    echo "Invalid option. Exiting."
    exit 1
    ;;
esac

