variable "project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "region" {
  description = "Region for GCP resources"
  type        = string
  default     = "asia-south1"
}

variable "zone" {
  description = "Zone for GCP resources"
  type        = string
  default     = "asia-south1-a"
}

variable "vpc_name" {
  description = "Name of VPC"
  type        = string
  default     = "gke-vpc"
}

variable "public_subnet_cidr" {
  description = "CIDR for public subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  description = "CIDR for private subnet"
  type        = string
  default     = "10.0.2.0/24"
}

variable "pod_range_cidr" {
  description = "CIDR for pod IP range"
  type        = string
  default     = "10.3.0.0/16"
}

variable "service_range_cidr" {
  description = "CIDR for service IP range"
  type        = string
  default     = "10.4.0.0/16"
}

variable "cluster_name" {
  description = "Name of GKE cluster"
  type        = string
  default     = "gke-cluster"
}

variable "node_pool_count" {
  description = "Number of nodes in each pool"
  type        = number
  default     = 2
}

variable "machine_type" {
  description = "Machine type for nodes"
  type        = string
  default     = "e2-medium"
}