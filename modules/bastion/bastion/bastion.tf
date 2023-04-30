resource "aws_instance" "bastion" {
    ami = data.aws_ami.amazon_linux.id

    instance_type = var.instance_type
    subnet_id     = local.public_subnets

    key_name        = var.key_pair_name
    security_groups = [var.security_group_name]

    tags = merge({Name = local.instance_name},
                var.tags)
}