data "aws_subnet" "private" {
  for_each  = toset(data.aws_subnets.private.ids)
  id        = each.value
}

data "aws_subnets" "private" {
    filter {
      name      = "tag:Name"
      values    = ["Dev-Marques-Ops-private-vpc"]
    }
}

data "aws_vpc" "vpc" {
    filter {
      name = "tag:Name"
      values = ["Dev-Marques-Ops-vpc"]
    }
}