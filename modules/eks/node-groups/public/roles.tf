resource "aws_iam_role" "public-eks-node-group" {
    name                = local.iam_role_name
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

resource "aws_iam_role_policy_attachment" "public-eks-node-group" {
    for_each = toset(var.policies)

    role        = aws_iam_role.public-eks-node-group.name
    policy_arn  = "arn:aws:iam::aws:policy/${each.value}"
}