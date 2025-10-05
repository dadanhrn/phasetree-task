# module "alb" {
#     source = "../aws/alb"
#     vpc_id = var.vpc_id
#     cidr_block = var.cidr_block
# }

module "ecr" {
    source = "../aws/ecr"
    repository_name = "iac-task-${var.name}"
}

# module "ecs" {
#     source = "../aws/ecs"
#     alb_arn = module.alb.arn
#     cpu_num = var.cpu_num
#     mem_size = var.mem_size
#     port = 3000
#     task_count = var.task_count
#     env = var.name
#     env_vars = var.env_vars
#     logs = {
#       group_name = "asd"
#       region = var.default_region
#     }
# }
