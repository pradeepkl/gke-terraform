# VPC
resource "google_compute_network" "vpc" {
  name                    = var.vpc_name
  auto_create_subnetworks = false
}

# Public Subnet
resource "google_compute_subnetwork" "public" {
  name          = "public-subnet"
  ip_cidr_range = var.public_subnet_cidr
  network       = google_compute_network.vpc.id
  region        = var.region

  secondary_ip_range {
    range_name    = "pod-range"
    ip_cidr_range = var.pod_range_cidr
  }
  secondary_ip_range {
    range_name    = "service-range"
    ip_cidr_range = var.service_range_cidr
  }
}

# Private Subnet
resource "google_compute_subnetwork" "private" {
  name          = "private-subnet"
  ip_cidr_range = var.private_subnet_cidr
  network       = google_compute_network.vpc.id
  region        = var.region
  private_ip_google_access = true
}

# Cloud Router
resource "google_compute_router" "router" {
  name    = "gke-router"
  network = google_compute_network.vpc.id
  region  = var.region
}

# NAT Gateway
resource "google_compute_router_nat" "nat" {
  name                               = "gke-nat"
  router                            = google_compute_router.router.name
  region                            = var.region
  nat_ip_allocate_option            = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}