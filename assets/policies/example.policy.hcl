path "pki*" {
   capabilities = ["read", "list"]
}

path "pki/sign/example" {
   capabilities = ["create", "update"] 
}

path "pki/issue/example" { 
  capabilities = ["create"] 
}

path "auth/kubernetes/login" {
  capabilities = ["create", "read", "update", "patch", "delete", "list"]
}
