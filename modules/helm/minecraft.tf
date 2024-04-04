resource "kubernetes_namespace" "minecraft" {
  metadata {
    name = "minecraft"
  }
}

resource "helm_release" "router" {
  name       = "mc-router"
  repository = "https://itzg.github.io/minecraft-server-charts/"
  chart      = "mc-router"
  namespace = kubernetes_namespace.minecraft.metadata[0].name
}

resource "helm_release" "minecraft" {
  name       = "minecraft"
  repository = "https://itzg.github.io/minecraft-server-charts/"
  chart      = "minecraft"
  namespace = kubernetes_namespace.minecraft.metadata[0].name
  set {
    name = "minecraftServer.eula"
    value = "true"
  }
  set {
    name = "minecraftServer.serviceType"
    value = "LoadBalancer"
  }
}