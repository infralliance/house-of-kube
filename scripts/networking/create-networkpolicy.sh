#!/bin/bash

# Function to check NetworkPolicies in a specific namespace
check_network_policies() {
    namespace=$1

    echo "Checking Network Policies in namespace: $namespace..."

    # List all NetworkPolicies in the specified namespace
    kubectl get networkpolicies -n $namespace
}

# Function to describe a specific NetworkPolicy in a namespace
describe_network_policy() {
    namespace=$1
    policy_name=$2

    echo "Describing Network Policy: $policy_name in namespace: $namespace..."
    kubectl describe networkpolicy $policy_name -n $namespace
}

# Function to create a default deny ingress NetworkPolicy
create_default_deny_ingress() {
    namespace=$1
    echo "Creating default deny ingress NetworkPolicy in namespace: $namespace..."

    kubectl apply -f - <<EOF
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: default-deny-ingress
  namespace: $namespace
spec:
  podSelector: {}
  policyTypes:
  - Ingress
EOF
    if [ $? -eq 0 ]; then
        echo "Default deny ingress NetworkPolicy created successfully."
    else
        echo "Failed to create default deny ingress NetworkPolicy."
    fi
}

# Function to create a default deny egress NetworkPolicy
create_default_deny_egress() {
    namespace=$1
    echo "Creating default deny egress NetworkPolicy in namespace: $namespace..."

    kubectl apply -f - <<EOF
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: default-deny-egress
  namespace: $namespace
spec:
  podSelector: {}
  policyTypes:
  - Egress
EOF
    if [ $? -eq 0 ]; then
        echo "Default deny egress NetworkPolicy created successfully."
    else
        echo "Failed to create default deny egress NetworkPolicy."
    fi
}

# Function to create a custom NetworkPolicy based on user input
create_custom_network_policy() {
    namespace=$1
    echo "Creating a custom NetworkPolicy for namespace: $namespace"

    # Choose the name of the NetworkPolicy
    read -p "Enter the name for the custom NetworkPolicy: " policy_name

    # Choose the types of policy (Ingress, Egress)
    echo "Choose the type of policy to apply:"
    echo "1. Ingress"
    echo "2. Egress"
    read -p "Enter your choice (1-2): " policy_types_choice

    case $policy_types_choice in
        1)
            policy_types="Ingress"
            ;;
        2)
            policy_types="Egress"
            ;;
        *)
            echo "Invalid choice, please choose either 1 (Ingress) or 2 (Egress)."
            exit 1
            ;;
    esac

    # Ingress rules selection (if Ingress is chosen)
    if [ "$policy_types" == "Ingress" ]; then
        echo "Select Ingress rules:"
        echo "1. By IP Block"
        echo "2. By Namespace"
        echo "3. By Pod Selector"
        echo "4. No Ingress rule (leave empty)"
        read -p "Enter your choice for Ingress (1-4): " ingress_choice

        case $ingress_choice in
            1)
                read -p "Enter the CIDR for IP Block (e.g., 172.17.0.0/16): " ingress_ip_block
                ingress_rule="- from:\n    - ipBlock:\n        cidr: $ingress_ip_block"
                ;;
            2)
                read -p "Enter the namespace label (e.g., project=myproject): " ingress_namespace_label
                ingress_rule="- from:\n    - namespaceSelector:\n        matchLabels:\n          $ingress_namespace_label"
                ;;
            3)
                read -p "Enter the pod label (e.g., role=frontend): " ingress_pod_label
                ingress_rule="- from:\n    - podSelector:\n        matchLabels:\n          $ingress_pod_label"
                ;;
            4)
                ingress_rule=""
                ;;
            *)
                echo "Invalid choice for Ingress, no Ingress rule applied."
                ingress_rule=""
                ;;
        esac
    fi

    # Egress rules selection (if Egress is chosen)
    if [ "$policy_types" == "Egress" ]; then
        echo "Select Egress rules:"
        echo "1. By IP Block"
        echo "2. By Namespace"
        echo "3. By Pod Selector"
        echo "4. No Egress rule (leave empty)"
        read -p "Enter your choice for Egress (1-4): " egress_choice

        case $egress_choice in
            1)
                read -p "Enter the CIDR for IP Block (e.g., 10.0.0.0/24): " egress_ip_block
                egress_rule="- to:\n    - ipBlock:\n        cidr: $egress_ip_block"
                ;;
            2)
                read -p "Enter the namespace label (e.g., project=anotherproject): " egress_namespace_label
                egress_rule="- to:\n    - namespaceSelector:\n        matchLabels:\n          $egress_namespace_label"
                ;;
            3)
                read -p "Enter the pod label (e.g., role=backend): " egress_pod_label
                egress_rule="- to:\n    - podSelector:\n        matchLabels:\n          $egress_pod_label"
                ;;
            4)
                egress_rule=""
                ;;
            *)
                echo "Invalid choice for Egress, no Egress rule applied."
                egress_rule=""
                ;;
        esac
    fi

    # Conditionally add Ingress and Egress sections
    ingress_section=""
    if [ -n "$ingress_rule" ]; then
        ingress_section="ingress:
  $ingress_rule"
    fi

    egress_section=""
    if [ -n "$egress_rule" ]; then
        egress_section="egress:
  $egress_rule"
    fi

    # Apply the custom NetworkPolicy
    echo "Applying the custom NetworkPolicy '$policy_name' in namespace: $namespace..."

    kubectl apply -f - <<EOF
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: $policy_name
  namespace: $namespace
spec:
  podSelector: {}
  policyTypes:
  - $policy_types
$ingress_section
$egress_section
EOF

    if [ $? -eq 0 ]; then
        echo "Custom NetworkPolicy '$policy_name' applied successfully!"
    else
        echo "Failed to apply custom NetworkPolicy '$policy_name'."
    fi
}

# Main function to interact with the user and perform actions
main() {
    echo "Welcome to the Kubernetes NetworkPolicy Management Script"
    echo "Please choose an option:"
    echo "1. Check Network Policies in a namespace"
    echo "2. Describe a Network Policy"
    echo "3. Create default deny ingress NetworkPolicy"
    echo "4. Create default deny egress NetworkPolicy"
    echo "5. Create a custom NetworkPolicy"
    echo "6. Exit"

    read -p "Enter choice (1-6): " choice

    case $choice in
        1)
            read -p "Enter namespace: " namespace
            check_network_policies $namespace
            ;;
        2)
            read -p "Enter namespace: " namespace
            read -p "Enter Network Policy name: " policy_name
            describe_network_policy $namespace $policy_name
            ;;
        3)
            read -p "Enter namespace: " namespace
            create_default_deny_ingress $namespace
            ;;
        4)
            read -p "Enter namespace: " namespace
            create_default_deny_egress $namespace
            ;;
        5)
            read -p "Enter namespace: " namespace
            create_custom_network_policy $namespace
            ;;
        6)
            echo "Exiting script."
            exit 0
            ;;
        *)
            echo "Invalid choice, please try again."
            ;;
    esac
}

# Call the main function to start the script
main

