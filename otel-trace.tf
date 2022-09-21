resource "helm_release" "otel_trace" {
  count             = 0
  name              = "otel-trace"
  chart             = "${local.project_root_path}/otel-trace"
  dependency_update = true
  atomic            = var.helm_atomic
  namespace         = "observability"
  timeout           = var.helm_timeout_unit
}
