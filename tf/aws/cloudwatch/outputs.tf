output "group_name" {
    description = "Logs group name"
    value = aws_cloudwatch_log_group.group.name
}