# GKE Infrastructure with Terraform

Production-ready GKE cluster infrastructure using Terraform.

## Features
- Private GKE cluster in asia-south1
- VPC with public/private subnets
- Cloud NAT and Cloud Router
- Regular and Spot (preemptible) node pools
- Security hardening with firewall rules
- State management in Google Cloud Storage

## Prerequisites
- Google Cloud SDK
- Terraform >= 1.0
- Access to GCP project with required permissions
- Enabled APIs:
  - Container
  - Compute Engine
  - Cloud Resource Manager
  - IAM

## Project Structure
```
.
├── main.tf                 # Backend configuration, API enablement
├── networking.tf           # VPC, subnets, NAT configuration
├── firewall.tf            # Network security rules
├── gke.tf                 # GKE cluster configuration
├── node-pools.tf          # Node pool definitions
├── variables.tf           # Variable declarations
├── outputs.tf             # Output definitions
├── providers.tf           # Provider configuration
├── versions.tf            # Version constraints
└── terraform.tfvars.example  # Example variable values
```

## Quick Start
1. Copy terraform.tfvars.example:
```bash
cp terraform.tfvars.example terraform.tfvars
```

2. Update terraform.tfvars with your values:
```hcl
project_id          = "your-project"
region             = "asia-south1"
zone               = "asia-south1-a"
```

3. Initialize and apply:
```bash
terraform init
terraform plan
terraform apply
```

## Configuration Details

### Networking
- VPC: Custom mode VPC
- Public subnet: 10.0.1.0/24
- Private subnet: 10.0.2.0/24
- Pod CIDR: 10.1.0.0/16
- Service CIDR: 10.2.0.0/16

### Node Pools
- Regular Pool:
  - e2-medium (2 vCPU, 4GB RAM)
  - 2 nodes
  - Standard persistent disk
- Spot Pool:
  - e2-medium
  - 2 preemptible nodes
  - Cost optimized

## Security Features
- Private nodes
- Node authorization
- Network policies
- Secure master access
- Firewall rules for internal communication

## State Management
State stored in Google Cloud Storage:
```hcl
terraform {
  backend "gcs" {
    bucket = "tf-state-gke-cluster"
    prefix = "terraform/state"
  }
}
```

## Cost Optimization
- Mix of regular and preemptible nodes
- Efficient subnet design
- Right-sized node instances
- Automated node repairs

## Cleanup
Delete all resources:
```bash
terraform destroy
```
