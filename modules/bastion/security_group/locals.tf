locals {
    security_group_name = "bastion-allow_ssh"
    vpc_name            = "${var.prefix_name}-vpc"

    ingress = {
        from_port   = var.ports.ingress
        to_port     = var.ports.ingress
        protocol    = var.protocol.ingress
        cidr_blocks = [var.cidrs.ipv4]
    }

    egress = {
        from_port           = var.ports.egress
        to_port             = var.ports.egress
        protocol            = var.protocol.egress
        cidr_blocks         = [var.cidrs.ipv4]
        ipv6_cidr_blocks    = [var.cidrs.ipv6]
    }
}