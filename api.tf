resource "helm_release" "api" {
  count             = 1
  name              = "api"
  chart             = "${local.project_root_path}/api/.helm"
  dependency_update = true
  namespace         = "api"
  timeout           = var.helm_timeout_unit
  atomic            = var.helm_atomic
  depends_on = [
    helm_release.certificates[0],
    helm_release.ms[0]
  ]

  set {
    name  = "cloudProvider.isLocal"
    value = "true"
  }

  set {
    name  = "env.MS_HOST"
    value = "ms.ms"
  }

  set {
    name = "env.OTEL_TRACE_HOST"
    # value = "otel-trace-opentelemetry-collector.observability"
    value = "otel-trace-collector.observability"
  }

  set {
    name  = "env.OTEL_TRACE_PORT"
    value = "4317"
  }

  set {
    name  = "env.NEXT_PUBLIC_DOMAIN_NAME"
    value = "${var.sld}.${var.tld}"
  }

  set {
    name  = "env.SCHEME"
    value = "https"
  }

  set {
    name  = "ingress.annotations.${replace("kubernetes.io/ingress.class", ".", "\\.")}"
    value = local.ingress_class_mapping[var.environment]
  }

  set {
    name  = "ingress.hosts[0].host"
    value = "${var.sld}.${var.tld}"
  }

  set {
    name  = "ingress.hosts[0].paths[0].path"
    value = "/"
  }

  set {
    name  = "ingress.hosts[0].paths[0].pathType"
    value = "ImplementationSpecific"
  }
}
