variable "project_name" {
  type = string
  description = "PROJECT's NAME"
}

variable "eks_cluster_roles" {
  type = map(string)
  description = "Map of EKS cluster role (name, arn)"
}

variable "eks_masters_role" {
  type = map(string)
  description = "Map of EKS masters role (namespace, ARN)"
}

variable "k8s_version" {
  type = string
  description = "Kubernetes version"
}

variable "cluster_subnet_ids" {
  type = list(string)
  description = "Subnets where EKS control plane place ENI"
}

variable "public_access_cidrs" {
  type = list(string)
  description = "Source to public access endpoint"
}

variable "node_group_name" {
  type = string
  description = "Node group name"
}

variable "node_group_subnet_ids" {
  type = list(string)
  description = "Subnets where node group be placed"
}