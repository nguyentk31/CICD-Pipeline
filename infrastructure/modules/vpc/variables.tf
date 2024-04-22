variable "project_name" {
  type = string
  description = "PROJECT's NAME"
}

variable "vpc_cidr" {
  type = string
  description = "IPv4 CIDR block for VPC"
}

variable "number_public_subnets" {
  type = number
  description = "Number of Public Subnets"
}

variable "number_private_subnets" {
  type = number
  description = "Number of Private Subnets"
}