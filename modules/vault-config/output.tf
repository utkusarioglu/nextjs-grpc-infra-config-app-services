output "vault_kubernetes_mount_path" {
  # value = join("", ["/v1/auth/", vault_auth_backend.kubernetes[0].path])
  value = "/v1/auth/${vault_auth_backend.kubernetes[0].path}"
}
