resource "kubernetes_namespace" "monitoring" {
  metadata {
    name = "monitoring"
  }
}

resource "helm_release" "prometheus" {
  name       = "prometheus"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  namespace  = kubernetes_namespace.monitoring.metadata[0].name
  set {
    name  = "prometheusOperator.service.type"
    value = "LoadBalancer"
  }
  set {
    name  = "grafana.enabled"
    value = "false"
  }
}

resource "helm_release" "grafana" {
  name       = "grafana"
  repository = "https://grafana.github.io/helm-charts"
  chart      = "grafana"
  namespace  = kubernetes_namespace.monitoring.metadata[0].name
  set {
    name  = "service.type"
    value = "LoadBalancer"
  }
  set {
    name  = "adminPassword"
    value = random_password.grafana.result
  }
  set {
    name  = "persistence.enabled"
    value = true
  }
}

resource "random_password" "grafana" {
  length = 8
}

output "grafana_password" {
  value = random_password.grafana.result
  sensitive = true
}