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