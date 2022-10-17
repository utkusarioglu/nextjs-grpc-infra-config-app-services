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

variable "environment" {
  description = "The environment in which the cluster is being provisioned"
  type        = string

  validation {
    condition     = contains(["local", "aws"], var.environment)
    error_message = "Allowed values for variable `environment` are: local, aws"
  }
}

variable "ingress_sg" {
  type        = string
  description = "Ingress security group"
}

variable "deployment_mode" {
  type        = string
  description = "Specify a mode that determines which resources will be deployed. Example: 'all' deploys everything"
}
