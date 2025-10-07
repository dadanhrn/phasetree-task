module "alb" {
    source = "../aws/alb"
    env = var.name
    vpc_id = var.vpc_id
    cidr_block_1 = var.cidr_block_1
    cidr_block_2 = var.cidr_block_2
}

module "ecr" {
    source = "../aws/ecr"
    repository_name = "iac-task-${var.name}"
}

module "ecs" {
    source = "../aws/ecs"
    tg_alb_arn = module.alb.target_group_arn
    subnet_id = module.alb.subnet_id
    cpu_num = var.cpu_num
    mem_size = var.mem_size
    port = 3000
    task_count = var.task_count
    env = var.name
    env_vars = var.env_vars
    logs = {
      group_name = "putra-applogs-${var.name}"
      region = var.default_region
    }
}
