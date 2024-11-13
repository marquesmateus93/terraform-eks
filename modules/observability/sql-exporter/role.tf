resource "aws_iam_role" "sql-exporter-role" {
  count = var.is_enabled ? 1:0

  name  = local.sql-exporter-role.name

  assume_role_policy = jsonencode({
    "Version" = "2012-10-17",
    "Statement" = [{
      "Effect" = "Allow",
      "Action" = [
        "sts:AssumeRoleWithWebIdentity"
      ],
      "Principal" = {
        "Federated" = var.oidc_provider
      },
      "Condition":{
        "StringEquals": {
          "${local.sql-exporter-role.oidc_eks_without_protocol}:sub" = "system:serviceaccount:${local.sql-exporter-deployment.metadata.namespace}:${local.sql-exporter-deployment.serviceaccount.name}",
          "${local.sql-exporter-role.oidc_eks_without_protocol}:aud" = "sts.amazonaws.com"
        }
      }
    }]
  })
}

resource "aws_iam_policy" "sql-exporter-policy" {
  count       = var.is_enabled ? 1:0

  name        = local.sql-exporter-policy.name
  description = ""
  policy      = jsonencode({
    "Version" = "2012-10-17",
    "Statement" = [{
      "Effect" = "Allow",
      "Action" = [
        "secretsmanager:GetSecretValue",
        "secretsmanager:DescribeSecret"
      ],
      "Resource" = [
        data.aws_secretsmanager_secret.sql-exporter-secrets-manager.arn
      ]
    }]
  })

  depends_on = [
    aws_iam_role.sql-exporter-role
  ]
}

resource "aws_iam_role_policy_attachment" "sql-exporter-policy-attachment" {
  count      = var.is_enabled ? 1:0

  role       = aws_iam_role.sql-exporter-role[count.index].name
  policy_arn = aws_iam_policy.sql-exporter-policy[count.index].arn

  depends_on = [
    aws_iam_policy.sql-exporter-policy
  ]
}