resource "vault_auth_backend" "kubernetes" {
  count = local.deployment_configs.vault.count
  type  = "kubernetes"
}

resource "vault_kubernetes_auth_backend_config" "kubernetes" {
  count           = local.deployment_configs.vault.count
  backend         = vault_auth_backend.kubernetes[0].path
  kubernetes_host = "https://kubernetes.default:443"
}

resource "vault_kubernetes_auth_backend_role" "issuer" {
  depends_on = [
    vault_kubernetes_auth_backend_config.kubernetes[0]
  ]
  backend                          = vault_auth_backend.kubernetes[0].path
  role_name                        = "issuer"
  bound_service_account_names      = ["issuer"]
  bound_service_account_namespaces = local.deployment_configs.namespaces.for_each
  token_ttl                        = 3600
  token_policies = [
    vault_policy.all["policies/example.policy.hcl"].name,
    vault_policy.all["policies/admin.policy.hcl"].name
  ]
  audience = null
  # audience = "cert-manager"
}
