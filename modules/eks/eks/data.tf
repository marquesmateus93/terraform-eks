data "aws_iam_policy_document" "policy_document" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["eks.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

data "aws_subnets" "subnets" {
  filter {
    name   = "tag:Name"
    values = [
      "Dev-Marques-Ops-public-*",
      "Dev-Marques-Ops-private-*"]
  }
}

data "tls_certificate" "certificate" {
  url = aws_eks_cluster.eks.identity[0].oidc[0].issuer
}