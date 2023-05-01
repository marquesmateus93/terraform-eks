resource "aws_iam_role" "eks" {
    name                = local.eks_assume_role_name
    assume_role_policy  = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_role_policy_attachment" "eks" {
    for_each = toset(var.policies)
    
    role        = aws_iam_role.eks.name
    policy_arn  = "arn:aws:iam::aws:policy/${each.value}"
}