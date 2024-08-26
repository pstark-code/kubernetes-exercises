#/bin/sh

## Kubeview
helm repo add --force-update "kubeview" "https://pstark-code.github.io/kubeview/"
helm upgrade --install "my-kubeview" "kubeview/kubeview" --create-namespace --namespace "kubeview" --values "./kubeview-values.yml"

## Kubernetes Dashboard
helm repo add --force-update kubernetes-dashboard "https://kubernetes.github.io/dashboard/"
helm upgrade --install "my-kubernetes-dashboard" "kubernetes-dashboard/kubernetes-dashboard" --create-namespace --namespace "kubernetes-dashboard" --values "./dashboard-values.yml"
