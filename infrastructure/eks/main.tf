// EKS CLUSTER
resource "aws_eks_cluster" "cluster" {
  name     = var.cluster_name
  role_arn = aws_iam_role.cluster-role.arn
  version = var.k8s_version

  access_config {
    authentication_mode = "API_AND_CONFIG_MAP"
    bootstrap_cluster_creator_admin_permissions = true
  }

  vpc_config {
    endpoint_public_access = true
    endpoint_private_access = true
    subnet_ids = var.cluster_subnet_ids
  }

  kubernetes_network_config {
    service_ipv4_cidr = "172.16.0.0/16"
  }
}

// EKS NODE GROUP
resource "aws_eks_node_group" "app-node-group" {
  cluster_name    = aws_eks_cluster.cluster.name
  node_group_name = "application-managed-node-group"
  # node_role_arn   = aws_iam_role.nodes-role.arn
  node_role_arn = data.aws_iam_role.lab-role.arn
  subnet_ids      = var.node_group_subnet_ids

  scaling_config {
    desired_size = 1
    max_size     = 3
    min_size     = 1
  }

  update_config {
    max_unavailable = 1
  }

  lifecycle {
    ignore_changes = [scaling_config[0].desired_size] // Ignore desired size 
  }

}

// EKS ACCESS ENTRY AND POLICY
resource "aws_eks_access_entry" "master-ae" {
  cluster_name      = aws_eks_cluster.cluster.name
  principal_arn     = aws_iam_role.users-role[0].arn
  user_name              = "master"
}

resource "aws_eks_access_policy_association" "master-ap" {
  cluster_name  = aws_eks_cluster.cluster.name
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
  principal_arn = aws_iam_role.users-role[0].arn

  access_scope {
    type       = "cluster"
  }
}

resource "aws_eks_access_entry" "admin-ae" {
  cluster_name      = aws_eks_cluster.cluster.name
  principal_arn     = aws_iam_role.users-role[0].arn
  user_name              = "admin"
}

resource "aws_eks_access_policy_association" "admin-ap" {
  cluster_name  = aws_eks_cluster.cluster.name
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSAdminPolicy"
  principal_arn = aws_iam_role.users-role[0].arn

  access_scope {
    type       = "cluster"
  }
}

resource "aws_eks_access_entry" "dev-ae" {
  cluster_name      = aws_eks_cluster.cluster.name
  principal_arn     = aws_iam_role.users-role[1].arn
  user_name              = "developer"
}

resource "aws_eks_access_policy_association" "dev-ap" {
  cluster_name  = aws_eks_cluster.cluster.name
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSEditPolicy"
  principal_arn = aws_iam_role.users-role[1].arn

  access_scope {
    type       = "namespace"
    namespaces = ["application"]
  }
}

resource "aws_eks_access_entry" "test-ae" {
  cluster_name    = aws_eks_cluster.cluster.name
  principal_arn   = aws_iam_role.users-role[2].arn
  user_name          = "tester"
}

resource "aws_eks_access_policy_association" "test-ap" {
  cluster_name    = aws_eks_cluster.cluster.name
  policy_arn      = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSViewPolicy"
  principal_arn   = aws_iam_role.users-role[2].arn

  access_scope {
    type       = "namespace"
    namespaces = ["application"]
  }
}

// AWS EKS (Elastic Kubernetes) Pod Identity Association.
resource "aws_eks_pod_identity_association" "pod-ia" {
  cluster_name    = aws_eks_cluster.cluster.name
  namespace       = "kube-system"
  service_account = "aws-node"
  role_arn        = aws_iam_role.pod-role.arn
}