output "cluster_name" {
  description = "GKE cluster name"
  value       = google_container_cluster.primary.name
}

output "cluster_endpoint" {
  description = "GKE cluster endpoint"
  value       = google_container_cluster.primary.endpoint
  sensitive   = true
}

output "cluster_ca_certificate" {
  description = "GKE cluster CA certificate"
  value       = google_container_cluster.primary.master_auth[0].cluster_ca_certificate
  sensitive   = true
}

output "vpc_name" {
  description = "The VPC name"
  value       = google_compute_network.vpc.name
}

output "public_subnet_name" {
  description = "The public subnet name"
  value       = google_compute_subnetwork.public.name
}

output "private_subnet_name" {
  description = "The private subnet name"
  value       = google_compute_subnetwork.private.name
}