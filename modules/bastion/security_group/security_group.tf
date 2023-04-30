resource "aws_security_group" "allow_ssh" {
    name            = local.security_group_name
    description     = "Allow SSH port from anywhere to access the Kubernetes cluster."
    vpc_id          = data.aws_vpc.vpc.id

    ingress {
        from_port   = local.ingress.from_port
        to_port     = local.ingress.to_port
        protocol    = local.ingress.protocol
        cidr_blocks = local.ingress.cidr_blocks
    }

    egress {
        from_port           = local.egress.from_port
        to_port             = local.egress.to_port
        protocol            = local.egress.protocol
        cidr_blocks         = local.egress.cidr_blocks
        ipv6_cidr_blocks    = local.egress.ipv6_cidr_blocks
    }

    tags = merge({Name = local.security_group_name},
                var.tags)
}