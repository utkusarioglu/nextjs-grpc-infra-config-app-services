resource "vault_auth_backend" "userpass" {
  count = local.deployment_configs.vault.count
  type  = "userpass"
}

resource "vault_generic_endpoint" "utkusarioglu" {
  count                = local.deployment_configs.vault.count
  path                 = "auth/${vault_auth_backend.userpass[0].path}/users/utkusarioglu"
  ignore_absent_fields = true

  data_json = <<-EOT
  {
    "policies": ["admin", "eaas-client"],
    "password": "pass1"
  }
  EOT

  depends_on = [
    vault_auth_backend.userpass[0]
  ]
}
