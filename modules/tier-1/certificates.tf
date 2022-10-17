resource "helm_release" "certificates" {
  count             = local.deployment_configs.certificates.count
  name              = "certificates"
  chart             = "${var.project_root_path}/certificates"
  dependency_update = true
  timeout           = var.helm_timeout_unit
  atomic            = var.helm_atomic

  set {
    name  = "publicDomainName"
    value = "${var.sld}.${var.tld}"
  }

  depends_on = [
    helm_release.cert_manager[0]
  ]
}
