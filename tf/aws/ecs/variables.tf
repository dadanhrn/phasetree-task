variable "env" {
  type = string
}

variable "tg_alb_arn" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "cpu_num" {
  type = number
}

variable "mem_size" {
  type = number
}

variable "port" {
  type = number
  default = 3000
}

variable "task_count" {
  type = number
}

variable "env_vars" {
  type = map(string)
  default = {}
}

variable "logs" {
  type = object({
    group_name = string
    region = string
  })
}
