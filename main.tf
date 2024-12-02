# main.tf
# This file acts as the entry point, referencing other configuration files

terraform {
  backend "gcs" {
    bucket = "tf-state-gke-cluster"
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

# IAM role for GKE service account
resource "google_project_iam_member" "gke_sa" {
  project = var.project_id
  role    = "roles/container.nodeServiceAccount"
  member  = "serviceAccount:${var.project_id}.svc.id.goog[default/default]"

  depends_on = [
    google_container_cluster.primary
  ]
}