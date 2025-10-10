output "arn" {
  value = aws_lb.default_lb.arn
}

output "target_group_arn" {
  value = aws_lb_target_group.tg_alb.arn
}

output "subnet_id" {
  value = aws_subnet.subnet1.id
}

output "dns_name" {
  value = aws_lb.default_lb.dns_name
}