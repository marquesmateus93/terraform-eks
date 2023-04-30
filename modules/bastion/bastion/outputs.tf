output "public_subnets" {
  value = sort(data.aws_subnet_ids.public.ids)[0]
}