data "aws_iam_policy_document" "assume_role" {
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