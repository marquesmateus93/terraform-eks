resource "aws_iam_role" "grafana-role" {
  count               = var.is_enabled ? 1:0

  name                = local.grafana-role.name
  assume_role_policy = jsonencode({
    "Version"   = "2012-10-17",
    "Statement" = [{
      "Sid"     = "Grafana",
      "Effect"  = "Allow",
      "Action"  = [
        "sts:AssumeRole"
      ],
      "Principal" = {
        Service = "grafana.amazonaws.com"
      }
    }]
  })

  tags = merge({Name = local.grafana-role.name},
              var.tags)
}

resource "aws_iam_role_policy" "grafana-role-policy" {
  count   = length(aws_iam_role.grafana-role)

  name    = local.grafana-policy.name
  role    = aws_iam_role.grafana-role[*].id
  policy  = jsonencode({
    "Version"   = "2012-10-17"
    "Statement" = [{
      "Sid"     = "PrometheusDatasource",
      "Effect"  = "Allow"
      "Action"  = [
        "aps:ListWorkspaces",
        "aps:DescribeWorkspace",
        "aps:QueryMetrics",
        "aps:GetLabels",
        "aps:GetSeries",
        "aps:GetMetricMetadata"
      ]
      "Resource" = "*"
    }]
  })

  depends_on = [
    aws_iam_role.grafana-role
  ]
}