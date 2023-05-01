locals {
  instance_name     = "${var.prefix_name}-bastion"
  vpc               = "${var.prefix_name}-vpc"
  pubic_subnet      = "${var.prefix_name}-public-vpc"
}