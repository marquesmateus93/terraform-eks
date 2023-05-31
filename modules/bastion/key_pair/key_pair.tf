resource "aws_key_pair" "bastion" {
  count = var.is_bastion_enable ? 1:0

  key_name    = local.key_pair
  public_key  = var.public_key

  tags = merge({Name = local.key_pair},
                var.tags)
}