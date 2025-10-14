<<<<<<< HEAD
# AWS region
variable "aws_region" {
  description = "AWS region where resources will be created"
  default     = "us-east-1"
}

# VPC CIDR block
variable "vpc_cidr" {
  description = "CIDR block for the main VPC"
  default     = "10.0.0.0/16"
}

# Public subnets
variable "public_subnet_cidrs" {
  description = "CIDRs for public subnets"
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

# Private subnets
variable "private_subnet_cidrs" {
  description = "CIDRs for private subnets"
  default     = ["10.0.101.0/24", "10.0.102.0/24"]
}

# EKS cluster name
variable "cluster_name" {
  description = "Name of the EKS cluster"
  default     = "weather-app-eks"
}

# Node group EC2 instance type
variable "node_instance_type" {
  description = "Instance type for worker nodes"
  default     = "t3.medium"
}

# Node group scaling
variable "desired_capacity" {
  description = "Desired number of nodes in node group"
  default     = 2
}

variable "max_size" {
  description = "Maximum number of nodes in node group"
  default     = 3
}

variable "min_size" {
  description = "Minimum number of nodes in node group"
  default     = 1
=======
#VPC CIDR BLOCK
variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  default = "10.0.0.0/16"
}
variable "public_subnet_cidrs" {
  description = "The CIDR blocks for the public subnets"
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}
variable "private_subnet_cidrs" {
  description = "The CIDR blocks for the private subnets"
  default = ["10.0.101.0/24", "10.0.102.0/24"]
>>>>>>> 6d9bf85 (delete workflow)
}
