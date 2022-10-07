resource "helm_release" "secrets" {
  count             = 1
  name              = "secrets"
  chart             = "${var.project_root_path}/secrets"
  dependency_update = true
  atomic            = true

  depends_on = [
    kubernetes_namespace.all["api"],
    kubernetes_namespace.all["ms"],
    kubernetes_namespace.all["observability"],
    kubernetes_namespace.all["cert-manager"],
  ]
}
