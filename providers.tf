provider "kubernetes" {
  config_path            = var.use_kubeconfig ? var.kubeconfig_filename : null
  host                   = var.use_kubeconfig ? null : "https://${module.gke.endpoint}"
  token                  = var.use_kubeconfig ? null : data.google_client_config.default.access_token
  cluster_ca_certificate = var.use_kubeconfig ? null : base64decode(module.gke.ca_certificate)
}

provider "kubectl" {
  load_config_file       = var.use_kubeconfig
  host                   = var.use_kubeconfig ? null : "https://${module.gke.endpoint}"
  token                  = var.use_kubeconfig ? null : data.google_client_config.default.access_token
  cluster_ca_certificate = var.use_kubeconfig ? null : base64decode(module.gke.ca_certificate)
  apply_retry_count      = 2
}
