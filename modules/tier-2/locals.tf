locals {
  ingress_class_mapping = {
    "aws"   = "alb"
    "local" = "public"
  }

  ingress_paths = {
    api = {
      aws   = "/*"
      local = "/"
    }
  }

  ingress_service_types = {
    aws   = "NodePort"
    local = "ClusterIP"
  }

  deployment_config_presets = {
    all = {
      api = {
        count = 1
      }
      grafana = {
        count = 1
      }
      jaeger = {
        count = 1
      }
      loki = {
        count = 1
      }
      ms = {
        count = 1
      }
      otel_collectors = {
        count = 1
      }
      ethereum_pvc = {
        count = 1
      }
      ethereum_storage = {
        count = 1
      }
      prometheus = {
        count = 1
      }
      kubernetes_dashboard = {
        count = 1
      }
    }

    ethereum_storage = {
      api = {
        count = 0
      }
      grafana = {
        count = 1
      }
      jaeger = {
        count = 1
      }
      loki = {
        count = 1
      }
      ms = {
        count = 0
      }
      otel_collectors = {
        count = 1
      }
      ethereum_pvc = {
        count = 1
      }
      ethereum_storage = {
        count = 1
      }
      prometheus = {
        count = 1
      }
      kubernetes_dashboard = {
        count = 0
      }
    }
  }

  deployment_configs = local.deployment_config_presets[var.deployment_mode]
}
