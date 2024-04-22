output "cluster_role" {
  value = aws_iam_role.cluster-role.arn
  description = "ARN of EKS cluster role"
}
output "nodegroup_role" {
  value = aws_iam_role.nodegroup-role.arn
  description = "ARN of EKS nodegroup role"
}
output "pod_role" {
  value = aws_iam_role.pod-role.arn
  description = "ARN of EKS pod role"
}
output "admins_role" {
  value = aws_iam_role.admins-role[*].arn
  description = "ARN of EKS admins role"
}
output "test" {
  value = aws_iam_role.admins-role[*].tags["env"]
  description = "ARN of EKS admins role"
}