resource "aws_iam_role" "news-eks-role" {
    name                = local.news-eks-role.name
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

    tags = merge({Name = local.news-eks-role.name},
                var.tags)
}

resource "aws_iam_role_policy_attachment" "news-eks-policy-attachment" {
    for_each = toset(var.policies)
    
    role        = aws_iam_role.news-eks-role.name
    policy_arn  = "arn:aws:iam::aws:policy/${each.value}"

    depends_on = [
        aws_iam_role.news-eks-role
    ]
}