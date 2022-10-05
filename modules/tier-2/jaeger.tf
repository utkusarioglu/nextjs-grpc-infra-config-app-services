resource "helm_release" "jaeger" {
  count             = 1
  name              = "jaeger"
  chart             = "${local.project_root_path}/jaeger"
  dependency_update = true
  namespace         = "observability"
  timeout           = var.helm_timeout_unit
  atomic            = var.helm_atomic

  values = [
    yamlencode({
      ingress = {
        hosts = [
          "jaeger.${var.sld}.${var.tld}"
        ]
        ingressClass        = local.ingress_class_mapping[var.environment]
        awsSecurityGroups   = var.ingress_sg
        externalDnsHostname = "jaeger.${var.sld}.${var.tld}"
      }
    })
  ]
}
