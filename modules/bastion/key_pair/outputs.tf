output "key_pair_id" {
    value = [
        for key_pair in aws_key_pair.bastion : key_pair.id
    ]
}

output "is_bastion_enable" {
    value = var.is_bastion_enable
}