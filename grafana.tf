resource "helm_release" "grafana" {
  // TODO this is off on kubernetes 1.25 because of podSecurityPolicy deprecation
  count             = 0
  name              = "grafana"
  chart             = "${local.project_root_path}/grafana"
  dependency_update = true
  namespace         = "observability"
  timeout           = var.helm_timeout_unit
  atomic            = var.helm_atomic
  recreate_pods     = true

  set {
    name  = "grafana.ingress.hosts"
    value = "{grafana.${var.sld}.${var.tld}}"
  }
}
