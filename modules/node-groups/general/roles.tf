resource "aws_iam_role" "iaris-general-role-node-group" {
    name                = local.iaris-general-role-node-group.name
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

    tags = merge({Name = local.iaris-general-role-node-group.name},
                var.tags)
}

resource "aws_iam_role_policy_attachment" "iaris-general-role-policy-attachment-node-group" {
    for_each = toset(var.policies)

    role        = aws_iam_role.iaris-general-role-node-group.name
    policy_arn  = "arn:aws:iam::aws:policy/${each.value}"

    depends_on = [
        aws_iam_role.iaris-general-role-node-group
    ]
}

resource "aws_iam_role_policy" "iaris-general-role-policy-node-group" {
    name = local.iaris-general-role-policy-node-group.name
    role   = aws_iam_role.iaris-general-role-node-group.id
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
    depends_on = [
        aws_iam_role.iaris-general-role-node-group
    ]
}