terraform {
  # cloud config by env
  cloud {}

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.41.0"
    }
  }
}