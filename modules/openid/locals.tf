locals {
  iaris-openid = {
    client_id_list = ["sts.${data.aws_partition.iaris-partition.dns_suffix}"]
  }

  connect_provider_name = "${var.prefix_name}-connect-provider${var.tags["environment"]}"
}