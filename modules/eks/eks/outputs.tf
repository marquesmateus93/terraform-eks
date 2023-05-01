output "cluster_name" {
  value = aws_eks_cluster.eks.name
}

output "eks_version" {
  value = aws_eks_cluster.eks.version
}