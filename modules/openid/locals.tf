locals {
  openid = {
    client_id_list = ["sts.${data.aws_partition.partition.dns_suffix}"]
  }

  connect_provider_name = "${var.prefix_name}-connect-provider-${var.tags["environment"]}"
}