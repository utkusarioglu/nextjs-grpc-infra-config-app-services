resource "helm_release" "otel_collectors" {
  count             = 1
  name              = "otel-collectors"
  chart             = "${local.project_root_path}/otel-collectors"
  dependency_update = true
  atomic            = var.helm_atomic
  namespace         = "observability"
  timeout           = var.helm_timeout_unit
}
