resource "helm_release" "loki" {
  // TODO this is off on kubernetes 1.25 because of podSecurityPolicy deprecation
  count = 1
  name  = "loki"
  chart = "${local.project_root_path}/loki"
  # chart             = "loki"
  # repository        = "https://grafana.github.io/helm-charts"
  # version           = "2.13.3"
  namespace         = "observability"
  dependency_update = true
  cleanup_on_fail   = true
  timeout           = var.helm_timeout_unit * 3
  atomic            = var.helm_atomic
}
