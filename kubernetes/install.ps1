# PowerShell script to install Kubernetes base platform components via Helm

Write-Host "Adding Helm repositories..." -ForegroundColor Cyan
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo add jetstack https://charts.jetstack.io
helm repo add external-secrets https://charts.external-secrets.io
helm repo add argo https://argoproj.github.io/argo-helm
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo add grafana https://grafana.github.io/helm-charts
helm repo add open-telemetry https://open-telemetry.github.io/opentelemetry-helm-charts

Write-Host "Updating Helm repositories..." -ForegroundColor Cyan
helm repo update

Write-Host "Installing Ingress NGINX..." -ForegroundColor Cyan
helm upgrade --install ingress-nginx ingress-nginx/ingress-nginx `
  --namespace ingress-nginx --create-namespace `
  --force-conflicts `
  -f kubernetes/ingress-nginx/values.yaml

Write-Host "Installing cert-manager..." -ForegroundColor Cyan
helm upgrade --install cert-manager jetstack/cert-manager `
  --namespace cert-manager --create-namespace `
  --force-conflicts `
  -f kubernetes/cert-manager/values.yaml

Write-Host "Installing External Secrets Operator..." -ForegroundColor Cyan
helm upgrade --install external-secrets external-secrets/external-secrets `
  --namespace external-secrets --create-namespace `
  --force-conflicts `
  -f kubernetes/external-secrets/values.yaml

Write-Host "Installing Argo CD..." -ForegroundColor Cyan
helm upgrade --install argocd argo/argo-cd `
  --namespace argocd --create-namespace `
  --force-conflicts `
  -f kubernetes/argocd/values.yaml

Write-Host "Kubernetes Base Platform components installation submitted." -ForegroundColor Green

Write-Host "Configuring External Secrets Operator integration with Azure Key Vault..." -ForegroundColor Cyan
kubectl annotate sa external-secrets -n external-secrets azure.workload.identity/client-id="9ee69626-3464-4ff7-a8c3-99f34ca853da" --overwrite

Write-Host "Applying ClusterSecretStore..." -ForegroundColor Cyan
kubectl apply -f kubernetes/external-secrets/secret-store.yaml

Write-Host "Applying Argo CD Ingress..." -ForegroundColor Cyan
kubectl apply -f kubernetes/argocd/ingress.yaml

Write-Host "Installing kube-prometheus-stack..." -ForegroundColor Cyan
helm upgrade --install prometheus prometheus-community/kube-prometheus-stack `
  --namespace monitoring --create-namespace `
  --force-conflicts `
  -f kubernetes/observability/prometheus-values.yaml

Write-Host "Installing Loki..." -ForegroundColor Cyan
helm upgrade --install loki grafana/loki `
  --namespace monitoring --create-namespace `
  --force-conflicts `
  -f kubernetes/observability/loki-values.yaml

Write-Host "Installing Tempo..." -ForegroundColor Cyan
helm upgrade --install tempo grafana/tempo `
  --namespace monitoring --create-namespace `
  --force-conflicts `
  -f kubernetes/observability/tempo-values.yaml

Write-Host "Installing OpenTelemetry Collector..." -ForegroundColor Cyan
helm upgrade --install otel-collector open-telemetry/opentelemetry-collector `
  --namespace monitoring --create-namespace `
  --force-conflicts `
  -f kubernetes/observability/otel-collector-values.yaml



