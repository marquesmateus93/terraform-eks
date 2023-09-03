resource "aws_iam_role" "iaris-alb-controller-role" {
  name = local.iaris-alb-controller-role.name

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
          "${var.oidc_without_protocol}:sub" = "system:serviceaccount:${var.helm.namespace}:${local.iaris-alb-controller-helm.service_account_name}",
          "${var.oidc_without_protocol}:aud" = "sts.amazonaws.com"
        }
      }
    }]
  })
}

resource "aws_iam_policy" "iaris-alb-controller-policy" {
  name        = local.iaris-alb-controller-policy.name
  description = "Policy body from GitHub document."
  policy      = data.http.iaris-alb-controller-policy-json.response_body

  depends_on = [
    data.http.iaris-alb-controller-policy-json,
    aws_iam_role.iaris-alb-controller-role
  ]
}

resource "aws_iam_role_policy_attachment" "iaris-alb-controller-policy-attachment" {
  role       = aws_iam_role.iaris-alb-controller-role.name
  policy_arn = aws_iam_policy.iaris-alb-controller-policy.arn

  depends_on = [
    aws_iam_policy.iaris-alb-controller-policy
  ]
}