resource "aws_iam_role" "public-eks-node-group" {
    name                =local.aws_iam_role
    assume_role_policy  = data.aws_iam_policy_document.public-eks-node-group.json
}

resource "aws_iam_role_policy_attachment" "public-eks-node-group" {
    for_each = toset(var.policies)

    role        = aws_iam_role.public-eks-node-group.name
    policy_arn  = "arn:aws:iam::aws:policy/${each.value}"
}