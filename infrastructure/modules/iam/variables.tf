variable "project_name" {
  type = string
  description = "PROJECT's NAME"
}

variable "github_account_id" {
  type = string
  description = "Github Actions account's ID"
}

variable "eks_namespaces" {
  type = list(string)
  description = "List of namespaces in EKS"
}

variable "eks_cluster_roles" {
  type = map(object({
    Version = string,
    Statement = list(object({
      Action = list(string),
      Effect = string,
      Principal = map(string)
    }))
  }))
  description = "Map of EKS cluster roles (name, trusted entities)"
}

variable "eks_policy_attachments" {
  type = list(map(string))
  description = "List of EKS policy attachments"
}
