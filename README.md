# 🏯 House of Kube

![Kubernetes](https://img.shields.io/badge/Kubernetes-Scripts-blue)
[![Docs](https://img.shields.io/badge/View-Docs-blue)](https://infralliance.github.io/house-of-kube/)

A curated CLI toolkit of scripts to create Kubernetes resources the easy way.

📦 Includes categorized folders with `kubectl apply` helpers for core, workloads, RBAC, autoscaling, networking, and more.

---

## 🚀 Quick Start

```bash
git clone https://github.com/infralliance/house-of-kube.git
cd house-of-kube
chmod +x run.sh
./run.sh
```

---

## 📁 Categories

- `setup/` – install kubectl, helm, minikube, k3s, etc.
- `core/` — Pod, Service, ConfigMap, Secret, Namespace...
- `workloads/` — Deployment, StatefulSet, DaemonSet, Job, CronJob
- `rbac/` — Role, ClusterRole, RoleBinding, ClusterRoleBinding
- `autoscaling/` — Horizontal Pod Autoscaler
- `networking/` — Ingress, NetworkPolicy
- `storage/` — StorageClass, PV, PVC, CSIDriver
- `policy/` — Admission controllers: Webhooks
- `crd/` — CustomResourceDefinition

---

## 🌐 Documentation

📝 Available via GitHub Pages:  
➡️ [https://infralliance.github.io/house-of-kube/](https://infralliance.github.io/house-of-kube/)

To regenerate the HTML docs:

```bash
./generate-docs.py
```

---
---

## 📛 Namespace Support

All scripts accept an optional namespace as the second argument.

When launched via `./run.sh`, you'll be prompted:

- Enter a resource name
- Optionally, specify a namespace (default used if left blank)

Example:

```bash
▶️ Running: create-configmap.sh my-config --namespace dev
```


## 🧾 License

**CC0 – Public Domain**  
Use freely, fork, remix, full copyleft.