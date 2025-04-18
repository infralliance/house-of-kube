#!/bin/bash

while true; do
  clear
  echo "📁 Select a category:"
  echo
  echo "   1) 🛠 setup          Install kubectl, helm, minikube, etc."
  echo "   2) 📦 core           Pods, Services, ConfigMaps, Namespaces"
  echo "   3) 🏗️ workloads     Deployments, StatefulSets, CronJobs, DaemonSets"
  echo "   4) 🌐 networking     Ingress, NetworkPolicies, EndpointSlice"
  echo "   5) 🔐 rbac           Roles, Bindings, Cluster Permissions"
  echo "   6) 📈 autoscaling    Horizontal & Vertical Pod Autoscalers"
  echo "   7) 💾 storage        PVCs, PVs, StorageClasses, CSI"
  echo "   8) 🛡️ policy        Admission controllers, PDBs"
  echo "   9) 🧬 crd            Custom Resource Definitions"
  echo "  10) 🚪 Exit"
  echo
  read -rp "#? " option

  case "$option" in
    1) folder="setup" ;;
    2) folder="core" ;;
    3) folder="workloads" ;;
    4) folder="networking" ;;
    5) folder="rbac" ;;
    6) folder="autoscaling" ;;
    7) folder="storage" ;;
    8) folder="policy" ;;
    9) folder="crd" ;;
    10) exit 0 ;;
    *) echo "Invalid option"; sleep 1; continue ;;
  esac

  scripts=$(find scripts/$folder -type f -name "create-*.sh" | sort)

  if [ -z "$scripts" ]; then
    echo "No scripts found in $folder"
    read -n 1 -s -r -p "Press any key to continue..."
    continue
  fi

  PS3="Select a script to run (or 'q' to go back): "
  select script in $scripts; do
    if [ -z "$script" ]; then
      break
    fi

    echo
    echo "🔍 What would you like to do with '$script'?"
    echo "   1) 🚀 Run"
    echo "   2) 🧪 View source"
    echo "   3) 🔙 Back to scripts"
    echo
    read -rp "#? " action

    case "$action" in
      1)
        echo "Running $script..."
        echo
        usage=$(grep -E '^#\s*Usage:' "$script")
        if [ -n "$usage" ]; then
          echo "$usage"
          echo
          args=""
          usage_args=$(echo "$usage" | sed -E 's/^#\s*Usage:\s*[^ ]+\s*//')
          for arg in $usage_args; do
            # Skip brackets and optionality marks
            clean_arg=$(echo "$arg" | sed -E 's/[\[\]<>]//g')
            read -rp "$clean_arg: " value
            args+="$value "
          done
        fi
        echo
        bash "$script" $args
        ;;
      2)
        echo
        cat "$script"
        ;;
      3)
        break
        ;;
      *)
        echo "Invalid action"
        ;;
    esac

    echo
    read -n 1 -s -r -p "Press any key to continue..."
    break
  done

done
