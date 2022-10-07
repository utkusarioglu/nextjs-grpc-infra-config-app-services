resource "helm_release" "networking" {
  count             = 0
  name              = "networking"
  chart             = "${var.project_root_path}/networking"
  dependency_update = true
  atomic            = true

  depends_on = [
    kubernetes_namespace.all["api"],
    kubernetes_namespace.all["ms"],
    kubernetes_namespace.all["observability"],
    kubernetes_namespace.all["cert-manager"],
  ]
}