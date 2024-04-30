terraform {
  # cloud config
  cloud {}

  # provider config
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.46.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_subnet" "uit" {
  vpc_id                  = var.vpc_id
  cidr_block              = cidrsubnet(var.vpc_cidr, 5, 0)

  tags = {
    Name                     = var.subnet_name
    iamge_tag = var.iamge_tag
    chart_version = var.chart_version
  }
}

variable "subnet_name" {
  type = string
}

variable "vpc_id" {
  type = string
  default = "nothing"
}

variable "vpc_cidr" {
  type = string
  default = "10.0.0.0/16"
}

variable "iamge_tag" {
  type = string
  default = "latest"
}
variable "chart_version" {
  type = string
  default = "latest"
}

output "iamge_tag" {
  value = aws_subnet.uit.tags.iamge_tag
}
output "chart_version" {
  value = aws_subnet.uit.tags.chart_version
}

output "subnet_id" {
  value = aws_subnet.uit.id
}

