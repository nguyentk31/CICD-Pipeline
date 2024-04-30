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


resource "aws_vpc" "uit" {
  cidr_block           = "10.31.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "${var.env}-vpc"
  }
}

variable "env" {
  type = string
}

output "vpc_id" {
  value = aws_vpc.uit.id
}

output "vpc_cidr" {
  value = aws_vpc.uit.cidr_block
}

output "vpc_name" {
  value = aws_vpc.uit.tags.Name
}