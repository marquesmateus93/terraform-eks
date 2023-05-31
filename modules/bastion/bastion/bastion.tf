resource "aws_instance" "bastion" {
    count = var.is_bastion_enable ? 1:0

    ami = data.aws_ami.amazon_linux[count.index].id

    instance_type = var.instance_type
    subnet_id     = data.aws_subnets.public.ids[0]

    key_name        = var.key_pair_name
    security_groups = [var.security_group_id]

    tags = merge({Name = local.instance_name},
                var.tags)
}