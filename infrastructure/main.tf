provider "aws" {
  region = "us-east-1"
}

# module "vpc" {
#   source = "./vpc"

#   project_name = var.project_name
#   vpc_cidr = "10.0.0.0/16"
#   number_public_subnets = 2
#   number_private_subnets = 2
# }

module "iam" {
  source = "./iam"

  project_name = var.project_name
  github_account_id = var.github_account_id
  eks_environments = ["prod", "dev"]
}

# data "aws_ami" "ubuntu" {
#   most_recent = true

#   filter {
#     name   = "name"
#     values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
#   }

#   filter {
#     name   = "virtualization-type"
#     values = ["hvm"]
#   }

#   owners = ["099720109477"] # Canonical
# }

# resource "aws_instance" "web" {
#   ami           = data.aws_ami.ubuntu.id
#   instance_type = "t3.micro"
#   subnet_id = module.vpc.public_subnets[0]
#   key_name = "vockey"

#   tags = {
#     Name = "HelloWorld"
#   }
# }

# resource "aws_ecr_repository" "repo" {
#   name = "${var.project_name}-repo"
#   force_delete = true
# }