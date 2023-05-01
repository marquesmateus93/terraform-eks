data "aws_iam_policy_document" "public-eks-node-group" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

data "aws_subnets" "public" {
    filter {
      name      = "tag:Name"
      values    = ["Dev-Marques-Ops-public-vpc"]
    }
}

data "aws_vpc" "vpc" {
    filter {
      name = "tag:Name"
      values = ["Dev-Marques-Ops-vpc"]
    }
}