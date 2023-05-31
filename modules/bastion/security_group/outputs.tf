output "security_group_id" {
    value = [
        for security_group in aws_security_group.allow_ssh : security_group.id
    ]
}