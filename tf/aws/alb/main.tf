resource "aws_lb" "default_lb" {
  name = "default-lb"
  load_balancer_type = "application"
  subnets = [aws_subnet.subnet.id]
}

resource "aws_subnet" "subnet" {
  vpc_id = var.vpc_id
  cidr_block = var.cidr_block
}