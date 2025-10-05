resource "aws_cloudwatch_log_group" "group" {
  name = "${var.resource}-${var.env}"
  tags = {
    env = var.env
  }
}