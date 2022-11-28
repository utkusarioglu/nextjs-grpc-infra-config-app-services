# resource "vault_auth_backend" "pki" {
#   count = local.deployment_configs.vault.count
#   type  = "pki"

#   tune {
#     max_lease_ttl = "8760h"
#   }
# }

resource "vault_mount" "pki" {
  count                 = local.deployment_configs.vault.count
  type                  = "pki"
  path                  = "pki"
  max_lease_ttl_seconds = 24 * 60 * 60
}

resource "vault_pki_secret_backend_root_cert" "pki" {
  # depends_on            = [vault_mount.pki]
  count                = local.deployment_configs.vault.count
  backend              = vault_mount.pki[0].path
  type                 = "internal"
  common_name          = "Root CA"
  ttl                  = "315360000"
  format               = "pem"
  private_key_format   = "der"
  key_type             = "rsa"
  key_bits             = 4096
  exclude_cn_from_sans = true
  # ou                   = "My OU"
  # organization         = "My organization"
}

resource "vault_pki_secret_backend_config_urls" "pki" {
  backend = vault_mount.pki[0].path
  issuing_certificates = [
    "https://vault.vault:8200/v1/pki/ca",
  ]
  crl_distribution_points = [
    "https://vault.vault:8200/v1/pki/crl"
  ]
}

resource "vault_pki_secret_backend_role" "example" {
  count            = local.deployment_configs.vault.count
  backend          = vault_mount.pki[0].path
  name             = "example"
  ttl              = 3600
  allow_ip_sans    = true
  key_type         = "rsa"
  key_bits         = 2048
  allowed_domains  = ["example.com", "example.domain.com"]
  allow_subdomains = true
}
