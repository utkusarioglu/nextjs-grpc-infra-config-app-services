resource "helm_release" "otel_operator" {
  count             = 1
  name              = "otel-operator"
  chart             = "opentelemetry-operator"
  repository        = "https://open-telemetry.github.io/opentelemetry-helm-charts"
  version           = "0.11.8"
  dependency_update = true
  atomic            = var.helm_atomic
  namespace         = "observability"
  timeout           = var.helm_timeout_unit * 3

  values = [
    yamlencode({
      admissionWebhooks = {
        certManager = {
          enabled = true
        }
      }
    })
  ]

  depends_on = [
    helm_release.cert_manager[0]
  ]
}
