variable "cluster_name" {
  type = string
  description = "EKS Cluster name"
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