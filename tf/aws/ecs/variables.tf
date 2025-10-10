variable "env" {
  description = "Environment name"
  type = string
}

variable "tg_alb_arn" {
  description = "ARN of load balancer target group"
  type = string
}

variable "cpu_num" {
  description = "Number of CPU unit (1024 = 1 CPU)"
  type = number
}

variable "mem_size" {
  description = "Allocated memory size (in MiB)"
  type = number
}

variable "port" {
  description = "Application port number"
  type = number
  default = 3000
}

variable "task_count" {
  description = "Application instance replica count"
  type = number
}

variable "env_vars" {
  description = "Environment variables"
  type = map(string)
  default = {}
}

variable "logs" {
  description = "Logs group name"
  type = object({
    group_name = string
    region = string
  })
}
