data "aws_ami" "amazon_linux" {
    most_recent = true

    filter {
      name      = "architecture"
      values    = ["x86_64"]
    }

    filter {
      name      = "image-type"
      values    = ["machine"]
    }

    filter {
      name      = "root-device-type"
      values    = ["ebs"]
    }

    filter {
      name      = "virtualization-type"
      values    = ["hvm"]
    }

    filter {
      name      = "owner-id"
      values    = ["795624187241"]
    }
}

data "aws_vpc" "vpc" {
  filter {
    name   = "tag:Name"
    values = [local.vpc]
  }
}

data "aws_subnet_ids" "public" {
  vpc_id = data.aws_vpc.vpc.id

  filter {
    name   = "tag:Name"
    values = [local.pubic_subnet]
  }
}