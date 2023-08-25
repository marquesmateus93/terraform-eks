resource "aws_iam_openid_connect_provider" "iaris-openid" {
  url             = var.oidc
  client_id_list  = local.iaris-openid.client_id_list
  thumbprint_list = var.thumbprint_list

  tags = merge({Name = local.connect_provider_name},
              var.tags)
}