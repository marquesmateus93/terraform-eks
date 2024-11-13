data "aws_subnets" "subnets" {
  filter {
    name   = "tag:Name"
    values = var.subnets
  }
}

data "tls_certificate" "certificate" {
  url = aws_eks_cluster.eks.identity[0].oidc[0].issuer

  depends_on = [
    aws_eks_cluster.eks
  ]
}