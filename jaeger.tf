resource "helm_release" "jaeger" {
  count             = 1
  name              = "jaeger"
  chart             = "${local.project_root_path}/jaeger"
  dependency_update = true
  namespace         = "observability"
  timeout           = var.helm_timeout_unit
  atomic            = var.helm_atomic
  # depends_on = [
  #   helm_release.ingress[0]
  # ]

  set {
    name  = "ingress.hosts"
    value = "{jaeger.${var.sld}.${var.tld}}"
  }
}
