resource "aws_iam_role" "csi" {
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
          "${var.oidc_without_protocol}:sub" = "system:serviceaccount:kube-system:ebs-csi-controller-sa",
          "${var.oidc_without_protocol}:aud" = "sts.amazonaws.com"
        }
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "csi" {
  for_each = toset(var.policies)

  role       = aws_iam_role.csi.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/${each.value}"
}