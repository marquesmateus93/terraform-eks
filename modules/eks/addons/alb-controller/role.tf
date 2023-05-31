resource "aws_iam_role" "alb-controller" {
  name = local.role_name

  assume_role_policy = jsonencode({
    "Version" = "2012-10-17",
    "Statement" = [{
      "Effect" = "Allow",
      "Action" = [
        "sts:AssumeRoleWithWebIdentity"
      ],
      "Principal" = {
        "Federated" = var.openid
      },
      "Condition":{
        "StringEquals": {
          "${var.oidc_without_protocol}:sub" = "system:serviceaccount:${var.assume_role_policy.namespace}:${var.assume_role_policy.serviceAccountName}",
          "${var.oidc_without_protocol}:aud" = "sts.amazonaws.com"
        }
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "alb-controller" {
  role       = aws_iam_role.alb-controller.name
  policy_arn = aws_iam_policy.alb-controller.arn
}