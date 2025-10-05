output "arn" {
  value = aws_lb.default_lb.arn
}

output "subnet_id" {
  value = aws_subnet.subnet.id
}