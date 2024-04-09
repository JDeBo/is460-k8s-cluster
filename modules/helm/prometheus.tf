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
    name  = "grafana.ingress.enabled"
    value = "true"
  }
  set {
    name  = "grafana.ingress.ingressClassName"
    value = "nginx"
  }

}

resource "kubernetes_ingress_class_v1" "nginx" {
  metadata {
    name = "nginx"
  }

  spec {
    controller = "k8s.io/ingress-nginx"
  }
}