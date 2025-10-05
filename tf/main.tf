terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 5.92"
    }
  }

  required_version = ">= 1.2"
}

provider "aws" {
    region = var.region
    access_key = var.access_key
    secret_key = var.secret_key

    default_tags {
      tags = {
        Creator = "putra"
        Project = "iac-task"
      }
    }
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

module "env_dev" {
    source = "./env"
    name = "development"
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.1.0/24"
    default_region = var.region
}

# module "env_prod" {
#     source = "./env"
#     name = "prod"
#     vpc_id = aws_vpc.main.id
#     cidr_block = "10.0.2.0/24"
#     default_region = "eu-central-1"
# }