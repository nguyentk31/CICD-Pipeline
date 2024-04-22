variable "eks_roles" {
  type = list(object({
    role_name = string
    trusted_entities = string
  }))
  description = "List of roles in EKS"
}

variable "eks_policy_attachments" {
  type = list(object({
    role_name = string
    policy_arn = string
  }))
  description = "List of policy attachments in EKS"
}

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
