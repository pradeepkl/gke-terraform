# main.tf
# This file acts as the entry point, referencing other configuration files

terraform {
  backend "gcs" {
    bucket = "tf-state-gke-cluster-training"
    prefix = "terraform/state"
  }
}

# Network resources are defined in networking.tf
# Firewall rules are defined in firewall.tf
# GKE cluster configuration is defined in gke.tf
# Node pools are defined in node-pools.tf

# Additional project-level configurations
resource "google_project_service" "services" {
  for_each = toset([
    "container.googleapis.com",
    "compute.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "iam.googleapis.com"
  ])
  
  project = var.project_id
  service = each.key

  disable_dependent_services = true
  disable_on_destroy        = false
}

data "google_service_account" "default_node_pool" {
  account_id = "default-node-pool"
  project    = "trainer-gketraining21"
}

resource "google_service_account" "gke_node_service_account" {
  count        = data.google_service_account.default_node_pool.id == null ? 1 : 0
  account_id   = "default-node-pool"
  display_name = "GKE Node Service Account"
  project      = "trainer-gketraining21"
}

resource "google_project_iam_member" "gke_sa" {
  project = "trainer-gketraining21"
  role    = "roles/container.nodeServiceAccount"
  member  = "serviceAccount:${data.google_service_account.default_node_pool.id != null ? data.google_service_account.default_node_pool.email : google_service_account.gke_node_service_account[0].email}"

  depends_on = [
    google_container_cluster.primary
  ]
}