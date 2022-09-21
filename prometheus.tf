resource "helm_release" "prometheus" {
  count             = 1
  name              = "prometheus"
  chart             = "${local.project_root_path}/prometheus"
  dependency_update = true
  namespace         = "observability"
  timeout           = var.helm_timeout_unit
  atomic            = var.helm_atomic

  set {
    name  = "prometheus.server.ingress.hosts"
    value = "{prometheus.${var.sld}.${var.tld}}"
  }
}
