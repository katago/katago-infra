resource "kubernetes_namespace" "web" {
  metadata {
    name = "katago-web"
  }
}