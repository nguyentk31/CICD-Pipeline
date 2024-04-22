variable "project_name" {
  type = string
  description = "PROJECT's NAME"
}

variable "github_account_id" {
  type = string
  description = "Github Actions account's ID"
}

variable "eks_environments" {
  type = list(string)
  description = "List of namespaces in EKS"
}