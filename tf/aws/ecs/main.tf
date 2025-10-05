resource "aws_ecs_service" "backend" {
  name = "backend"
  launch_type = "FARGATE"
  task_definition = aws_ecs_task_definition.instance.arn
  cluster = aws_ecs_cluster.instance_cluster.arn
  desired_count = var.task_count
  
  load_balancer {
    target_group_arn = var.alb_arn
    container_name = "backend"
    container_port = 3000
  }
}

resource "aws_ecs_task_definition" "instance" {
  family = "backend"
  container_definitions = jsonencode([
    {
      name = "backend"
      image = ""
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

module "cloudwatch" {
    source = "../cloudwatch"
    resource = "ecs"
    env = var.env
}