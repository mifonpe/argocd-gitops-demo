locals {
  tags = {
    Environment = "demo"
    Region      = "eu"
  }

  eks_cluster_name = "gitops-helm-cluster"
}
