resource "aws_security_group" "bastion" {
    count = var.is_bastion_enable ? 1:0

    name        = local.bastion_security_group_name
    description = "Allow SSH port from Bastion host."
    vpc_id      = data.aws_vpc.vpc.id

    ingress {
        from_port       = var.ports.ingress
        to_port         = var.ports.ingress
        protocol        = var.protocol.ingress
        security_groups = [var.security_groups]
    }

    egress {
        from_port           = var.ports.egress
        to_port             = var.ports.egress
        protocol            = var.protocol.egress
        cidr_blocks         = [var.cidrs.ipv4]
        ipv6_cidr_blocks    = [var.cidrs.ipv6]
    }

    tags = merge({Name = local.bastion_security_group_name},
                var.tags)
}

resource "aws_security_group" "rds" {
    name        = local.rds_security_group_name
    description = "Used for RDS instance to ingress."
    vpc_id      = data.aws_vpc.vpc.id

    egress {
        from_port           = var.ports.egress
        to_port             = var.ports.egress
        protocol            = var.protocol.egress
        cidr_blocks         = values(data.aws_subnet.private).*.cidr_block
    }

    tags = merge({Name = local.rds_security_group_name},
        var.tags)
}