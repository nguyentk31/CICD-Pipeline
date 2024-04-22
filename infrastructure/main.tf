provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source = "./vpc"

  vpc_name = "DACN"
  vpc_cidr = "10.0.0.0/16"
  number_public_subnets = 2
  number_private_subnets = 2
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
  subnet_id = module.vpc.public_subnets[0]
  key_name = "vockey"

  tags = {
    Name = "HelloWorld"
  }
}

resource "aws_ecr_repository" "repo" {
  name = "my-repo"
  force_delete = true
}