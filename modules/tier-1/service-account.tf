resource "kubernetes_service_account" "issuer" {
  depends_on = [
    kubernetes_namespace.all
  ]
  for_each = (
    local.deployment_configs.cert_manager.count > 0
    ? toset(local.deployment_configs.namespaces.for_each)
    : set()
  )

  metadata {
    name      = "issuer"
    namespace = each.key
  }
}


resource "kubernetes_secret_v1" "issuer" {
  depends_on = [
    kubernetes_service_account.issuer
  ]
  for_each = (
    local.deployment_configs.cert_manager.count > 0
    ? toset(local.deployment_configs.namespaces.for_each)
    : set()
  )
  metadata {
    name      = "issuer-service-account-token"
    namespace = each.key
    annotations = {
      "kubernetes.io/service-account.name" = (
        kubernetes_service_account.issuer[each.key].metadata[0].name
      )
    }
  }

  type = "kubernetes.io/service-account-token"
}
