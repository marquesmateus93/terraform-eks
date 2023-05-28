resource "aws_iam_openid_connect_provider" "openid" {
  url             = var.oidc
  client_id_list  = ["sts.${data.aws_partition.partition.dns_suffix}"]
  thumbprint_list = [var.thumbprint_list]

  tags = merge({name = local.connect_provider_name},
              var.tags)
}