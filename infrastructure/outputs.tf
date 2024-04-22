# Outputs of VPC
# output "vpc" {
#   value = module.vpc.aws_vpc.vpc.id
#   description = "VPC id"
# }
# output "public_subnets" {
#   value = module.vpc.aws_subnet.public-subnets[*].id
#   description = "Public subnets id"
# }

# output "private_subnets" {
#   value = module.vpc.aws_subnet.private-subnets[*].id
#   description = "Private subnets id"
# }

# Outputs of IAM
output "cluster_role" {
  value = module.iam.aws_iam_role.cluster-role.arn
  description = "ARN of EKS cluster role"
}
output "nodegroup_role" {
  value = module.iam.aws_iam_role.nodegroup-role.arn
  description = "ARN of EKS nodegroup role"
}
output "pod_role" {
  value = module.iam.aws_iam_role.pod-role.arn
  description = "ARN of EKS pod role"
}
output "admins_role" {
  value = module.iam.aws_iam_role.admins-role[*]
  description = "ARN of EKS admins role"
}
output "test" {
  value = module.iam.aws_iam_role.admins-role[*]
  description = "ARN of EKS admins role"
}