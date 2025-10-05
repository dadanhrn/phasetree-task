variable "name" {
  type = string
}

variable "cpu_num" {
    type = number
    default = 1
}

variable "mem_size" {
    type = number
    default = 512
}

variable "task_count" {
  type = number
  default = 1
}

variable "env_vars" {
  type = map(string)
  default = {}
}

variable "vpc_id" {
    type = string
}

variable "cidr_block" {
    type = string
}

variable "default_region" {
    type = string
}