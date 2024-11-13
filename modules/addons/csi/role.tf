resource "aws_iam_role" "csi-role" {
  name = local.csi-role.name

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
          "${var.oidc_without_protocol}:sub" = "system:serviceaccount:${var.helm.namespace}:${local.csi.service_account_name}",
          "${var.oidc_without_protocol}:aud" = "sts.amazonaws.com"
        }
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "csi-policy-attachment" {
  for_each = toset(var.policies)

  role       = aws_iam_role.csi-role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/${each.value}"

  depends_on = [
    aws_iam_role.csi-role
  ]
}