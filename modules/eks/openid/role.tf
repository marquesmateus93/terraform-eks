resource "aws_iam_role" "role" {
  name = local.role_name

  assume_role_policy = jsonencode({
    "Version" = "2012-10-17",
    "Statement" = [{
      "Effect" = "Allow",
      "Principal" = {
        "Federated" = aws_iam_openid_connect_provider.openid.id
      }
      "Action" = [
        "sts:AssumeRoleWithWebIdentity"
      ],
      "Condition":{
        "StringEquals": {
          "${var.oidc_without_protocol}:sub": "system:serviceaccount:default:s3ListSA"
        }
      }
    }]
  })

  tags = merge({name = local.role_name},
    var.tags)
}

resource "aws_iam_role_policy_attachment" "policy" {
  for_each    = toset(var.policies)

  role        = aws_iam_role.role.name
  policy_arn  = "arn:aws:iam::aws:policy/${each.value}"
}