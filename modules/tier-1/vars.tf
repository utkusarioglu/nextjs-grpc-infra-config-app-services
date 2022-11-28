variable "project_root_path" {
  type = string
}

variable "helm_timeout_unit" {
  type = number
}

variable "helm_atomic" {
  type = bool
}

variable "sld" {
  description = "Second level domain"
  type        = string
}

variable "tld" {
  description = "Top level domain: Ex: com of www.google.com"
  type        = string
}

variable "persistent_volumes_root" {
  type        = string
  description = "Root folder for all the persistent volumes attached to nodes"
}

variable "deployment_mode" {
  type        = string
  description = "Specify a mode that determines which resources will be deployed. Example: 'all' deploys everything"
}

variable "vault_kubernetes_mount_path" {
  type        = string
  description = "Mount path for the kubernetes auth backend of Vault"
}
