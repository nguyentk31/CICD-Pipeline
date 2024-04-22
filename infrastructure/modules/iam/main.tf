# // EKS CLUSTER ROLE
# resource "aws_iam_role" "cluster-role" {
#   name               = "${var.project_name}-cluster-role"
#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Action = "sts:AssumeRole"
#         Effect = "Allow"
#         Principal = {
#           Service = "eks.amazonaws.com"
#         }
#       },
#     ]
#   })
# }

# resource "aws_iam_role_policy_attachment" "cluster-AmazonEKSClusterPolicy" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
#   role       = aws_iam_role.cluster-role.name
# }

# // EKS NODE GROUP ROLE
# resource "aws_iam_role" "nodegroup-role" {
#   name               = "${var.project_name}-nodegroup-role"
#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Action = "sts:AssumeRole"
#         Effect = "Allow"
#         Principal = {
#           Service = "ec2.amazonaws.com"
#         }
#       },
#     ]
#   })
# }

# resource "aws_iam_role_policy_attachment" "nodegroup-AmazonEKSWorkerNodePolicy" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
#   role       = aws_iam_role.nodegroup-role.name
# }

# resource "aws_iam_role_policy_attachment" "nodegroup-AmazonEC2ContainerRegistryReadOnly" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
#   role       = aws_iam_role.nodegroup-role.name
# }

# // EKS POD ROLE
# resource "aws_iam_role" "pod-role" {
#   name               = "${var.project_name}-pod-role"
#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Action = ["sts:AssumeRole", "sts:TagSession"]
#         Effect = "Allow"
#         Sid    = "AllowEksAuthToAssumeRoleForPodIdentity"
#         Principal = {
#           Service = "pods.eks.amazonaws.com"
#         }
#       },
#     ]
#   })
# }

# resource "aws_iam_role_policy_attachment" "pod-AmazonEKSWorkerNodePolicy" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
#   role       = aws_iam_role.pod-role.name
# }

// EKS ADMINS ROLE ( Production, development admins)
resource "aws_iam_role" "admins-role" {
  count = length(var.eks_environments)
  name = "${var.project_name}-${var.eks_environments[count.index]}Admin-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          AWS = var.github_account_id
        }
      }
    ]
  })

  tags = {
    env = var.eks_environments[count.index]
  }
}

resource "aws_iam_role" "eks-roles" {
  count = length(var.eks_roles)
  name = "${var.project_name}-${var.eks_roles[count.index].role_name}-role"
  assume_role_policy = jsonencode(var.eks_roles[count.index].trusted_entities)
}

resource "aws_iam_role_policy_attachment" "eks-policy-attachment" {
  count = length(var.eks_policy_attachments)
  policy_arn = var.eks_policy_attachments[count.index].policy_arn
  role = "${var.project_name}-${var.eks_policy_attachments[count.index].role_name}-role"
}