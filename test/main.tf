variable "project_id" {
  description = "GCP project ID"
  type        = string
}

terraform {
  required_providers {
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "~> 1"
    }

    kubernetes = {
      version = "~> 2.8"
    }

    kustomization = {
      source  = "kbst/kustomization"
      version = "< 1"
    }

    random = {
      version = "~> 2"
    }

    shell = {
      source  = "scottwinkler/shell"
      version = "~> 1"
    }
  }
}

provider "kustomization" {
  kubeconfig_raw = ""
}

provider "google" {
  project     = var.project_id
  region      = "us-west1"
}

module "cluster" {
  source = "../"

  cluster_name = "clustername"
  customer_name = "customer_name"

  zones = ["us-west1-a", "us-west1-b"]
  region = "us-west1"
  subnetwork = "subnetwork"
  project_id = var.project_id
  network = "network"
}
