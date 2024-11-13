data "aws_vpc" "vpc" {
    filter {
        name   = "tag:Name"
        values = var.vpc
    }
}

data "aws_subnets" "private-subnets" {
    filter {
        name   = "tag:Name"
        values = var.subnets
    }
}