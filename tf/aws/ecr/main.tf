resource "aws_ecr_repository" "repository" {
  name = "iac-task-${var.env}"

  image_scanning_configuration {
    scan_on_push = true
  }
}