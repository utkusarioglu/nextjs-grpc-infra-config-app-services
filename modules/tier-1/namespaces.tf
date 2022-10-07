resource "kubernetes_namespace" "all" {
  for_each = toset(["api", "ms", "observability", "cert-manager"])
  metadata {
    name = each.key
  }
}
