resource "aws_iam_role" "gpu-role-ng" {
    name                = local.gpu-role-ng.name
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

    tags = merge({Name = local.gpu-role-ng.name},
                var.tags)
}

resource "aws_iam_role_policy_attachment" "gpu-policy-attachment-ng" {
    for_each = toset(var.policies)

    role        = aws_iam_role.gpu-role-ng.name
    policy_arn  = "arn:aws:iam::aws:policy/${each.value}"

    depends_on = [
        aws_iam_role.gpu-role-ng
    ]
}

resource "aws_iam_role_policy" "gpu-role-policy-ng" {
    name = local.gpu-role-policy-ng.name
    role   = aws_iam_role.gpu-role-ng.id
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
        aws_iam_role.gpu-role-ng
    ]
}