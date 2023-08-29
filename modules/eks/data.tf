data "aws_subnets" "subnets" {
  filter {
    name   = "tag:Name"
    values = [
      "iaris-public-subnet",
      "iaris-private-subnet"
    ]
  }
}

data "tls_certificate" "certificate" {
  url = aws_eks_cluster.iaris-eks.identity[0].oidc[0].issuer
}

data "aws_iam_role" "iaris-administrator-role" {
  name = "Administrator"
}

data "aws_iam_role" "iaris-genral-node-group-role" {
  name = "iaris-general-role-node-group-development"
}

data "aws_iam_role" "iaris-easyproctor-image-node-group-role" {
  name = "iaris-easyproctor-image-role-node-group-development"
}