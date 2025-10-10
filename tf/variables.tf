variable "region" {
    description = "AWS region"
    type = string
}

variable "access_key" {
  description = "AWS access key"
  type = string
  sensitive = true
}

variable "secret_key" {
    description = "AWS access secret key"
    type = string
    sensitive = true
}