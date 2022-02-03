module "internet" {
  source = "github.com/getupcloud/terraform-module-internet?ref=v1.0"
}

module "flux" {
  source = "github.com/getupcloud/terraform-module-flux?ref=v1.0"

  git_repo       = var.flux_git_repo
  manifests_path = "./clusters/${var.cluster_name}/gke/manifests"
  wait           = var.flux_wait
  flux_version   = var.flux_version

  manifests_template_vars = merge({
    alertmanager_cronitor_id : module.cronitor.cronitor_id
  }, var.manifests_template_vars)
}

module "cronitor" {
  source = "github.com/getupcloud/terraform-module-cronitor?ref=v1.0"

  cluster_name  = var.cluster_name
  customer_name = var.customer_name
  cluster_sla   = var.cluster_sla
  suffix        = "gke"
  tags          = [var.region]
  pagerduty_key = var.cronitor_pagerduty_key
  api_key       = var.cronitor_api_key
  api_endpoint  = module.gke.endpoint
}

data "google_client_config" "default" {}

module "gke" {
  source                     = "terraform-google-modules/kubernetes-engine/google//modules/private-cluster"
  project_id                 = var.project_id
  name                       = var.cluster_name
  region                     = var.region
  zones                      = var.zones
  network                    = var.network
  subnetwork                 = var.subnetwork
  ip_range_pods              = var.ip_range_pods
  ip_range_services          = var.ip_range_services
  http_load_balancing        = var.http_load_balancing
  horizontal_pod_autoscaling = var.horizontal_pod_autoscaling
  network_project_id         = var.network_project_id
  enable_private_endpoint    = var.enable_private_endpoint
  enable_private_nodes       = var.enable_private_nodes
  network_policy             = var.network_policy
  remove_default_node_pool   = var.remove_default_node_pool
  logging_service            = var.logging_service

  node_pools              = var.node_pools
  node_pools_oauth_scopes = var.node_pools_oauth_scopes
  node_pools_labels       = var.node_pools_labels
  node_pools_metadata     = var.node_pools_metadata
  node_pools_taints       = var.node_pools_taints
  node_pools_tags         = var.node_pools_tags

  configure_ip_masq           = var.configure_ip_masq
  default_max_pods_per_node   = var.default_max_pods_per_node
  master_authorized_networks  = var.master_authorized_networks
  impersonate_service_account = var.impersonate_service_account
  master_ipv4_cidr_block      = var.master_ipv4_cidr_block
  regional                    = var.regional
}
