data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.cluster.token
  load_config_file       = false
  version                = "1.13.2"
}


###############
# EKS Cluster #
###############
module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "17.23.0"
  cluster_name    = local.eks_cluster_name
  cluster_version = "1.21"
  subnets         = module.vpc.private_subnets
  enable_irsa     = true

  tags = merge(local.tags,
         {
           Kubernetes = true
         })

  vpc_id = module.vpc.vpc_id

  node_groups_defaults = {
    ami_type  = "AL2_x86_64"
    disk_size = 50
  }

  node_groups = {
    workers-1 = {
      name             = "${local.eks_cluster_name}-workers-1"
      desired_capacity = 1
      max_capacity     = 3
      min_capacity     = 1

      instance_type = "t3.medium"
      k8s_labels = {
        environment     = "demo"
        managed-worker  = "true"
      }
      additional_tags = {
        Name                                                  = "${local.eks_cluster_name}-workers-1"
        "k8s.io/cluster-autoscaler/enabled"                   = "true"
        "k8s.io/cluster-autoscaler/${local.eks_cluster_name}" = "owned"
      }
    }
  }

  map_users    = [
    {
      userarn  = ""
      username = "miguel"
      groups   = ["system:masters"]
    },
    {
      userarn  = ""
      username = "miguel-angel"
      groups   = ["system:masters"]
    }
  ]
}

######################################
# Cluster Autoscaler IAM Permissions #
######################################
resource "aws_iam_role_policy_attachment" "workers_autoscaling" {
  policy_arn = aws_iam_policy.worker_autoscaling.arn
  role       = module.eks.worker_iam_role_name
}

resource "aws_iam_policy" "worker_autoscaling" {
  name_prefix = "eks-worker-autoscaling-${module.eks.cluster_id}"
  description = "EKS worker node autoscaling policy for cluster ${module.eks.cluster_id}"
  policy      = data.aws_iam_policy_document.worker_autoscaling.json
  path        = "/eks/demo-cluster/"
}

data "aws_iam_policy_document" "worker_autoscaling" {
  statement {
    sid    = "eksWorkerAutoscalingAll"
    effect = "Allow"

    actions = [
      "autoscaling:DescribeAutoScalingGroups",
      "autoscaling:DescribeAutoScalingInstances",
      "autoscaling:DescribeLaunchConfigurations",
      "autoscaling:DescribeTags",
      "ec2:DescribeLaunchTemplateVersions",
    ]

    resources = ["*"]
  }

  statement {
    sid    = "eksWorkerAutoscalingOwn"
    effect = "Allow"

    actions = [
      "autoscaling:SetDesiredCapacity",
      "autoscaling:TerminateInstanceInAutoScalingGroup",
      "autoscaling:UpdateAutoScalingGroup",
    ]

    resources = ["*"]

    condition {
      test     = "StringEquals"
      variable = "autoscaling:ResourceTag/kubernetes.io/cluster/${module.eks.cluster_id}"
      values   = ["owned"]
    }

    condition {
      test     = "StringEquals"
      variable = "autoscaling:ResourceTag/k8s.io/cluster-autoscaler/enabled"
      values   = ["true"]
    }
  }
}
  
######################################
# Chartmuseum IAM Permissions #
######################################
  
resource "aws_iam_role_policy_attachment" "s3_access" {
  policy_arn = aws_iam_policy.s3_access.arn
  role       = module.eks.worker_iam_role_name
}
  
resource "aws_iam_policy" "s3_access" {
  name_prefix = "s3-chartmuseum-access"
  description = "Provides chartmuseum with access for its s3 backend"
  policy      = data.aws_iam_policy_document.s3_access.json
  path        = "/s3/demo-bucket/"
}

data "aws_iam_policy_document" "s3_access" {
  statement {
    sid    = "chartmuseumS3List"
    effect = "Allow"

    actions = [
      "s3:ListBucket"
    ]

    resources = ["arn:aws:s3:::argocd-gitops-demo-chartmuseum"]
  }

  statement {
    sid    = "chartmuseumS3Access"
    effect = "Allow"

    actions = [
        "s3:DeleteObject",
        "s3:GetObject",
        "s3:PutObject"
    ]

    resources = ["arn:aws:s3:::argocd-gitops-demo-chartmuseum/*"]
   
  }
}
