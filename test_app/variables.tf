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