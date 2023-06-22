resource "aws_iam_role" "private-eks-node-group" {
    count = var.is_private_node_group_enable ? 1:0

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