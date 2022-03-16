locals {
  kubeconfig_filename        = abspath(pathexpand(var.kubeconfig_filename))
  api_endpoint               = "https://${module.gke.endpoint}"
  token                      = data.google_client_config.default.access_token
  certificate_authority_data = base64decode(module.gke.ca_certificate)

  suffix = random_string.suffix.result
  secret = random_string.secret.result
}
