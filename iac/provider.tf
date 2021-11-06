terraform {
  required_version = "0.14.9"

  backend "s3" {
    encrypt = "true"
    bucket  = "terrastate-mfontanp"
    key     = "gitops-helm-summit/iac.tfstate"
    region  = "eu-west-1"
  }
}

provider "aws" {
  region  = "eu-west-1"
}
