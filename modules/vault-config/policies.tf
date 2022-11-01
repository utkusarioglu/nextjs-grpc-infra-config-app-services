# Create admin policy in the root namespace
resource "vault_policy" "admin_policy" {
  count  = local.deployment_configs.vault.count
  name   = "admin"
  policy = file("assets/policies/admin-policy.hcl")
}

# Create 'training' policy
resource "vault_policy" "eaas-client" {
  count  = local.deployment_configs.vault.count
  name   = "eaas-client"
  policy = file("assets/policies/eaas-client-policy.hcl")
}

resource "vault_policy" "web_app" {
  count  = local.deployment_configs.vault.count
  name   = "web_app"
  policy = file("assets/policies/web-app.policy.hcl")
}
