variable "name" {
  description = "Environment name"
  type = string
}

variable "cpu_num" {
    description = "Number of CPU unit (1024 = 1 CPU)"
    type = number
    default = 256
}

variable "mem_size" {
    description = "Allocated memory size (in MiB)"
    type = number
    default = 512
}

variable "task_count" {
  description = "Number of instance replica"
  type = number
  default = 1
}

variable "env_vars" {
  description = "Environment variables"
  type = map(string)
  default = {}
}

variable "vpc_id" {
    description = "VPC ID"
    type = string
}

variable "cidr_block_1" {
    description = "CIDR block 1"
    type = string
}

variable "cidr_block_2" {
    description = "CIDR block 2"
    type = string
}

variable "default_region" {
    description = "AWS region"
    type = string
}