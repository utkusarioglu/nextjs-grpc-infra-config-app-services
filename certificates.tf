resource "helm_release" "certificates" {
  count             = 1
  name              = "certificates"
  chart             = "${local.project_root_path}/certificates"
  dependency_update = true
  timeout           = var.helm_timeout_unit
  atomic            = var.helm_atomic
}
