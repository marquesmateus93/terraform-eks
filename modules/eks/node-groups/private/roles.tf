resource "aws_iam_role" "private-eks-node-group" {
    name                = local.iam_role_name
    managed_policy_arns = var.policies
    assume_role_policy  = jsonencode({
        "Version" = "2012-10-17"
        "Statement" = [{
            "Effect" = "Allow"
            "Principal"  = {
                "Service" = ["ec2.amazonaws.com"]
            }
            "Action" = [
                "sts:AssumeRole"
            ]
        }]
    })
}

resource "aws_iam_role_policy" "private-eks-node-group" {
    name = local.iam_role_policy
    role   = aws_iam_role.private-eks-node-group.id
    policy = jsonencode({
        "Version": "2012-10-17"
        "Statement" = [{
            "Effect" = "Allow"
            "Action" = [
                "elasticloadbalancing:Describe*"
            ]
            "Resource" = "*"
        }]
    })
}