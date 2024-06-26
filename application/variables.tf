# Main variables
variable "aws_region" {
  type        = string
  description = "AWS Region"
}

# EKS Variables
variable "cluster_name" {
  type        = string
  description = "EKS Cluster's name"
}

variable "cluster_endpoint" {
  type        = string
  description = "EKS Cluster's endpoint"
}

variable "cluster_ca" {
  type        = string
  description = "EKS Cluster's CA Certificate"
}

# LBC variables
variable "lbc_sa" {
  type        = string
  default     = "aws-load-balancer-controller"
  description = "Service Account's Name for LBC"
}

variable "lbc_namespace" {
  type        = string
  default     = "kube-system"
  description = "EKS Namespace to deploy LBC"
}

variable "lbc_role" {
  type        = string
  default     = "lbc_role"
  description = "AWS LBCr Role (ARN)"
}

# ECR URL
variable "image_ecr_url" {
  type        = string
  description = "Image ECR's URL"
}

variable "chart_ecr_url" {
  type        = string
  description = "Chart ECR's URL"
}

# Application's variables
variable "chart_version" {
  type        = string
  default     = "latest"
  description = "Helm chart name"
}

variable "image_tag" {
  type        = string
  default     = "latest"
  description = "Application image's tag"
}