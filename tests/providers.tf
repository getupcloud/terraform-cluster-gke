provider "shell" {
  enable_parallelism = true
  interpreter        = ["/bin/bash", "-c"]
}

provider "kubectl" {
  config_path       = var.kubeconfig_filename
  apply_retry_count = 2
}

provider "kubernetes" {
  config_path = var.kubeconfig_filename
}

provider "google" {
  project     = var.project_id
  region      = var.region
  credentials = var.service_account_key
}
