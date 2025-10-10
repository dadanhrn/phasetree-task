output "target_group_arn" {
  description = "Load balancer target group ARN"
  value = aws_lb_target_group.tg_alb.arn
}

output "dns_name" {
  description = "Load balancer DNS name"
  value = aws_lb.default_lb.dns_name
}