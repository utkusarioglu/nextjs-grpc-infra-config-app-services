locals {
  certs = {
    intermediate = {
      cert = file(".certs/intermediate/intermediate.crt")
    }
    ca = {
      cert = file(".certs/root/root.crt")
    }
    # vault = {
    #   cert = file(".certs/intermediate/intermediate.crt"),
    #   ca   = file(".certs/root/root.crt")
    #   bundle = join("", [
    #     local.certs.vault.cert,
    #     local.certs.vault.ca
    #   ])
    # }
  }
}
