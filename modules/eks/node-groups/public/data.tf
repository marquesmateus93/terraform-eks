data "aws_subnets" "public" {
    filter {
      name      = "tag:Name"
      values    = ["Dev-Marques-Ops-public-vpc"]
    }
}

data "aws_vpc" "vpc" {
    filter {
      name = "tag:Name"
      values = ["Dev-Marques-Ops-vpc"]
    }
}