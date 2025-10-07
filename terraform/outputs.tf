# EKS Cluster endpoint
output "cluster_endpoint" {
  description = "EKS Cluster endpoint for kubectl"
  value       = aws_eks_cluster.eks_cluster.endpoint
}

# EKS Cluster name
output "cluster_name" {
  description = "EKS Cluster name"
  value       = aws_eks_cluster.eks_cluster.name
}
