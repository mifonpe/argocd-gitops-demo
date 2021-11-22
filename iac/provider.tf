terraform {
  required_version = "1.0.2"

  backend "s3" {
    encrypt = "true"
    bucket  = "argocd-gitops-demo-spainclouds"
    key     = "eks/iac.tfstate"
    region  = "eu-west-1"
  }
}

provider "aws" {
  region  = "eu-west-1"
}
