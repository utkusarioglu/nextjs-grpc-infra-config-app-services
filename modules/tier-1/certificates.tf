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

  set {
    name  = "vaultIssuerRef.secretName"
    value = kubernetes_secret_v1.issuer["api"].metadata[0].name
    # value = "issuer-service-account-token"
  }

  set {
    name  = "vaultIssuerRef.mountPath"
    value = var.vault_kubernetes_mount_path
  }

  set {
    name = "vaultIssuerRef.caBundle"
    value = base64encode(join("", [
      file(".certs/intermediate/intermediate.crt"),
      file(".certs/root/root.crt")
    ]))
  }

  depends_on = [
    helm_release.cert_manager[0]
  ]
}
