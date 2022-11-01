resource "vault_auth_backend" "userpass" {
  count = local.deployment_configs.vault.count
  type  = "userpass"
}

resource "vault_generic_endpoint" "student" {
  count = local.deployment_configs.vault.count
  depends_on = [
    vault_auth_backend.userpass[0]
  ]
  # path                 = "auth/userpass/users/utkusarioglu"
  path                 = "auth/${vault_auth_backend.userpass[0].path}/users/utkusarioglu"
  ignore_absent_fields = true

  data_json = <<-EOT
  {
    "policies": ["admins", "eaas-client"],
    "password": "pass1"
  }
  EOT
}
