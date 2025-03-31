resource "aws_iam_role" "general-role-ng" {
    name                = local.general-role-ng.name
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

    tags = merge({Name = local.general-role-ng.name},
                var.tags)
}

resource "aws_iam_role_policy_attachment" "general-role-policy-attachment-ng" {
    for_each = toset(var.policies)

    role        = aws_iam_role.general-role-ng.name
    policy_arn  = "arn:aws:iam::aws:policy/${each.value}"

    depends_on = [
        aws_iam_role.general-role-ng
    ]
}

resource "aws_iam_role_policy" "general-role-policy-ng" {
    name = local.general-role-policy-ng.name
    role   = aws_iam_role.general-role-ng.id
    policy = jsonencode({
        "Version": "2012-10-17"
        "Statement" = [{
            "Effect" = "Allow"
            "Action" = [
                "elasticloadbalancing:Describe*",
                "AmazonSSMManagedInstanceCore"
            ]
            "Resource" = "*"
        }]
    })
    depends_on = [
        aws_iam_role.general-role-ng
    ]
}