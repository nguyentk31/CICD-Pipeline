project_name = "DACN"

# github_account_id = "992382851936" # Github-actions user id
github_account_id = "637423337672" # Learner-lab

eks_environments = ["prod", "dev"]

eks_roles = [
  {
    role_name = "cluster"
    trusted_entities = {
      Version = "2012-10-17"
      Statement = [
        {
          Action = "sts:AssumeRole"
          Effect = "Allow"
          Principal = {
            Service = "eks.amazonaws.com"
          }
        },
      ]
    }
  },
  {
    role_name = "nodegroup"
    trusted_entities = {
      Version = "2012-10-17"
      Statement = [
        {
          Action = "sts:AssumeRole"
          Effect = "Allow"
          Principal = {
            Service = "ec2.amazonaws.com"
          }
        },
      ]
    }
  },
  {
    role_name = "pod"
    trusted_entities = {
      Version = "2012-10-17"
      Statement = [
        {
          Action = ["sts:AssumeRole", "sts:TagSession"]
          Effect = "Allow"
          Principal = {
            Service = "pods.eks.amazonaws.com"
          }
        },
      ]
    }
  },
]

eks_policy_attachments = [
  {
    role_name = "cluster"
    policies_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  },
  {
    role_name = "nodegroup"
    policies_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  },
  {
    role_name = "nodegroup"
    policies_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  },
  {
    role_name = "pod"
    policies_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  },
]