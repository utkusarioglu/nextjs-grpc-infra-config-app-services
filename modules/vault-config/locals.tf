locals {
  deployment_config_presets = {
    all = {
      vault = {
        count = 1
      }
    }

    ethereum_storage = {
      vault = {
        count = 0
      }
    }

    up_till_cert_manager = {
      vault = {
        count = 1
      }
    }
  }

  deployment_configs = local.deployment_config_presets[var.deployment_mode]
}
