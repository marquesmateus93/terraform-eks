data "aws_region" "current_region" {}

data "aws_subnets" "subnets" {
    filter {
        name   = "tag:Name"
        values = var.subnets
    }
}