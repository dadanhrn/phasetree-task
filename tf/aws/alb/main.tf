resource "aws_lb" "default_lb" {
  name = "default-lb-${var.env}"
  load_balancer_type = "application"
  security_groups = [ aws_security_group.alb_security_group.id ]
  subnets = [aws_subnet.subnet1.id, aws_subnet.subnet2.id]
}

resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.default_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg_alb.arn
  }
}

resource "aws_lb_target_group" "tg_alb" {
  name        = "tg-alb-${var.env}"
  target_type = "ip"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
}

resource "aws_subnet" "subnet1" {
  vpc_id = var.vpc_id
  cidr_block = var.cidr_block_1
  availability_zone = "eu-central-1a"
}

resource "aws_subnet" "subnet2" {
  vpc_id = var.vpc_id
  cidr_block = var.cidr_block_2
  availability_zone = "eu-central-1b"
}

resource "aws_security_group" "alb_security_group" {
  name = "alb_security_group-${var.env}"
  vpc_id = var.vpc_id
}

resource "aws_vpc_security_group_ingress_rule" "allow_ipv4" {
  security_group_id = aws_security_group.alb_security_group.id
  cidr_ipv4         = "10.0.0.0/16"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.alb_security_group.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}