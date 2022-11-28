resource "kubernetes_service_account" "issuer" {
  depends_on = [
    kubernetes_namespace.all
  ]
  count = local.deployment_configs.cert_manager.count

  metadata {
    name      = "issuer"
    namespace = "cert-manager"
  }
}

resource "kubernetes_secret_v1" "issuer" {
  # for_each = local.deployment_configs.cert_manager.count == 0 ? toset() : toset(["cert-manager", "vault"])
  count = local.deployment_configs.cert_manager.count
  metadata {
    name      = "issuer-service-account-token"
    namespace = "cert-manager"
    annotations = {
      "kubernetes.io/service-account.name" = kubernetes_service_account.issuer[0].metadata[0].name
    }
  }

  type = "kubernetes.io/service-account-token"
}
