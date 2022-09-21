resource "helm_release" "otel_log" {
  count             = 1
  name              = "otel-log"
  chart             = "${local.project_root_path}/otel-log"
  dependency_update = true
  atomic            = var.helm_atomic
  namespace         = "observability"
  timeout           = var.helm_timeout_unit
}
