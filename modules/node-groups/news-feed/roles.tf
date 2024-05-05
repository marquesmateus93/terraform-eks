resource "aws_iam_role" "news-feed-role-ng" {
    name                = local.news-feed-role-ng.name
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

    tags = merge({Name = local.news-feed-role-ng.name},
                var.tags)
}

resource "aws_iam_role_policy_attachment" "news-feed-role-policy-attachment-ng" {
    for_each = toset(var.policies)

    role        = aws_iam_role.news-feed-role-ng.name
    policy_arn  = "arn:aws:iam::aws:policy/${each.value}"

    depends_on = [
        aws_iam_role.news-feed-role-ng
    ]
}

resource "aws_iam_role_policy" "news-feed-role-policy-node-group" {
    name = local.news-feed-role-policy-ng.name
    role   = aws_iam_role.news-feed-role-ng.id
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
        aws_iam_role.news-feed-role-ng
    ]
}