data "aws_subnets" "private-subnets" {
  filter {
    name   = "tag:Name"
    values = var.subnets
  }
}

data "aws_ssm_parameter" "eks-ami-release-version" {
  name = "/aws/service/eks/optimized-ami/${var.eks_version}/amazon-linux-2/recommended/release_version"
}