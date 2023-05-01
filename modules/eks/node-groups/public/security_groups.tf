resource "aws_security_group" "public-eks-node-group" {
    name        = local.security_group_name
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

    tags = merge({name = local.node_group_name},
                var.tags)
}