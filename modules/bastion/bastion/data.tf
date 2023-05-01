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
data "aws_subnets" "public" {
  filter {
    name   = "tag:Name"
    values = [local.pubic_subnet]
  }
}