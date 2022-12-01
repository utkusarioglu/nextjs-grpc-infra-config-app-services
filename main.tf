module "vault_config" {
  source = "./modules/vault-config"

  deployment_mode = var.deployment_mode
  secrets_path    = var.secrets_path
  assets_path     = var.assets_path
}

module "app_tier_1" {
  source = "./modules/tier-1"

  project_root_path           = local.project_root_path
  helm_timeout_unit           = var.helm_timeout_unit
  helm_atomic                 = var.helm_atomic
  sld                         = var.sld
  tld                         = var.tld
  persistent_volumes_root     = var.persistent_volumes_root
  deployment_mode             = var.deployment_mode
  vault_kubernetes_mount_path = module.vault_config.vault_kubernetes_mount_path
  tls_crt                     = local.certs.intermediate.cert
  ca_crt                      = local.certs.ca.cert

  depends_on = [
    module.vault_config
  ]
}

module "app_tier_2" {
  source = "./modules/tier-2"

  project_root_rel_path = var.project_root_rel_path
  helm_timeout_unit     = var.helm_timeout_unit
  helm_atomic           = var.helm_atomic
  sld                   = var.sld
  tld                   = var.tld
  environment           = "local"
  cluster_name          = var.cluster_name
  ingress_sg            = "not-needed-in-local"
  deployment_mode       = var.deployment_mode

  depends_on = [
    module.app_tier_1
  ]
}
