 # Terraform Cluster Template

## terraform.tfvars example
```terraform
project_id                 = "example-project-id"
name                       = "cluster-name-01"
description                = "Production Cluster"
region                     = "us-east1"
zones                      = ["us-east1-a", "us-east1-b", "us-east1-c"]
network                    = "vpc-01"
subnetwork                 = "us-east1-a-subnet-01"
ip_range_pods              = "us-east1-a-subnet-01-pods"
ip_range_services          = "us-east1-a-subnet-01-services"
http_load_balancing        = false
horizontal_pod_autoscaling = true
network_policy             = false
initial_node_count         = 1
configure_ip_masq          = false
default_max_pods_per_node  = "110"
kubernetes_version         = "1.21.0"
maintenance_exclusions = [
  {
    name       = "default-exclusion"
    start_time = "2019-01-01T00:00:00Z"
    end_time   = "2019-01-02T00:00:00Z"
  }
]
maintenance_start_time   = "05:00"
release_channel          = "STABLE"
remove_default_node_pool = false
cluster_autoscaling = {
  "enabled" : false,
  "gpu_resources" : [],
  "max_cpu_cores" : 0,
  "max_memory_gb" : 0,
  "min_cpu_cores" : 0,
  "min_memory_gb" : 0
}
grant_registry_access = true
node_pools = [
  {
    name               = "default-node-pool"
    machine_type       = "e2-medium"
    node_locations     = "us-central1-b,us-central1-c"
    min_count          = 1
    max_count          = 100
    local_ssd_count    = 0
    disk_size_gb       = 100
    disk_type          = "pd-standard"
    image_type         = "COS"
    auto_repair        = true
    auto_upgrade       = true
    service_account    = "project-service-account@teste.iam.gserviceaccount.com"
    preemptible        = false
    initial_node_count = 80
  },
  {
    name               = "default-node-pool2"
    machine_type       = "e2-medium"
    node_locations     = "us-central1-b,us-central1-c"
    min_count          = 1
    max_count          = 100
    local_ssd_count    = 0
    disk_size_gb       = 100
    disk_type          = "pd-standard"
    image_type         = "COS"
    auto_repair        = true
    auto_upgrade       = true
    service_account    = "project-service-account@teste.iam.gserviceaccount.com"
    preemptible        = false
    initial_node_count = 80
  },
]
node_pools_oauth_scopes = {
  all = []

  default-node-pool = [
    "https://www.googleapis.com/auth/cloud-platform",
  ]
}
node_pools_labels = {
  all = {}

  default-node-pool = {
    default-node-pool = true
  }
}
node_pools_metadata = {
  all = {}

  default-node-pool = {
    node-pool-metadata-custom-value = "my-node-pool"
  }
}
node_pools_taints = {
  all = []

  default-node-pool = [
    {
      key    = "default-node-pool"
      value  = true
      effect = "PREFER_NO_SCHEDULE"
    },
  ]
}
node_pools_tags = {
  all = []

  default-node-pool = [
    "default-node-pool",
  ]
}
```