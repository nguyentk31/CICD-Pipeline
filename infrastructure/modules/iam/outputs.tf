output "eks_cluster_roles" {
  value = { for role in aws_iam_role.eks-cluster-roles: role.tags.role => role.arn }
  description = "Map of EKS cluster role (name, arn)"
}

output "eks_masters_role" {
  value = { for role in aws_iam_role.eks-masters-role: role.tags.namespace => role.arn }
  description = "Map of EKS masters role (namespace, ARN)"
}

output "attachments_role" {
  value = aws_iam_role_policy_attachment.eks-policy-attachments[*]
  description = "List of EKS policy attachments"
}