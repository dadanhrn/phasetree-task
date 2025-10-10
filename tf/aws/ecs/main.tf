resource "aws_ecs_service" "backend" {
  name = "backend-${var.env}"
  launch_type = "FARGATE"
  task_definition = aws_ecs_task_definition.instance.arn
  cluster = aws_ecs_cluster.instance_cluster.arn
  desired_count = var.task_count
  
  load_balancer {
    target_group_arn = var.tg_alb_arn
    container_name = "backend-${var.env}"
    container_port = var.port
  }
}

resource "aws_ecs_task_definition" "instance" {
  family = "backend-${var.env}"
  requires_compatibilities = ["FARGATE"]
  execution_role_arn = aws_iam_role.ecs_task_execution_role.arn
  network_mode = "awsvpc"
  cpu = var.cpu_num
  memory = var.mem_size
  container_definitions = jsonencode([
    {
      name = "backend-${var.env}"
      image = "amazon/amazon-ecs-sample"
      cpu = var.cpu_num
      memory = var.mem_size
      essential = true
      portMappings = [
        {
          containerPort = var.port
          hostPort = var.port
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group" = module.cloudwatch.group_name
          "awslogs-stream-prefix" = "ecs_task"
          "awslogs-region" = var.logs.region
        }
      }
      environment = [for k, v in var.env_vars : {name = k, value = v}]
    }
  ])
}

resource "aws_ecs_cluster" "instance_cluster" {
  name = "instance_cluster"
}

resource "aws_iam_role" "ecs_task_execution_role" {
  name = "ecsTaskExecutionRole_${var.env}"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Effect    = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })
}

module "cloudwatch" {
    source = "../cloudwatch"
    resource = "ecs"
    env = var.env
}