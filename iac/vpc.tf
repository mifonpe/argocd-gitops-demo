module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.0.0"

  name                 = "gitops-helm-summit"
  cidr                 = "10.20.0.0/16"
  azs                  = data.aws_availability_zones.azs.names
  private_subnets      = ["10.20.1.0/24", "10.20.2.0/24", "10.20.3.0/24"]
  public_subnets       = ["10.20.4.0/24", "10.20.5.0/24", "10.20.6.0/24"]
  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true
  enable_dns_support   = true

  public_subnet_tags = {
    Visibility                                        = "public"
    "kubernetes.io/cluster/${local.eks_cluster_name}" = "shared"
    "kubernetes.io/role/elb"                          = "true"
  }

  private_subnet_tags = {
    Visibility                                        = "private"
    "kubernetes.io/cluster/${local.eks_cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"                 = "true"
  }

  tags = local.tags
}
