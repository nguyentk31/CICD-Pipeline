# EKS cluster roles
resource "aws_iam_role" "eks-cluster-roles" {
  for_each = var.eks_cluster_roles
  name = "${var.project_name}-${each.key}-role"
  assume_role_policy = jsonencode(each.value)

  tags = {
    role = each.key
  }
}

# EKS policy attachments
resource "aws_iam_role_policy_attachment" "eks-policy-attachments" {
  count = length(var.eks_policy_attachments)
  policy_arn = var.eks_policy_attachments[count.index].policy_arn
  role = "${var.project_name}-${var.eks_policy_attachments[count.index].role_name}-role"
  depends_on = [ aws_iam_role.eks-cluster-roles ]
}

// EKS masters role ( Production, Development namespace master)
resource "aws_iam_role" "eks-masters-role" {
  count = length(var.eks_namespaces)
  name = "${var.project_name}-${var.eks_namespaces[count.index]}Master-role"
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
    namespace = var.eks_namespaces[count.index]
  }
}
