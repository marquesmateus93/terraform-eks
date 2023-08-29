resource "aws_iam_role" "iaris-eks-role" {
    name                = local.iaris-eks-role.name
    assume_role_policy  = jsonencode({
        Version = "2012-10-17"
        Statement = [{
            Effect = "Allow"
            Action = "sts:AssumeRole"
            Principal = {
                Service = "eks.amazonaws.com"
            }
        }]
    })

    tags = merge({Name = local.iaris-eks-role.name},
        var.tags)
}

resource "aws_iam_role_policy_attachment" "iaris-eks-policy-attachment" {
    for_each = toset(var.policies)
    
    role        = aws_iam_role.iaris-eks-role.name
    policy_arn  = "arn:aws:iam::aws:policy/${each.value}"

    depends_on = [
        aws_iam_role.iaris-eks-role
    ]
}