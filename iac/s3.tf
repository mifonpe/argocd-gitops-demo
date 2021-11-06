resource "aws_s3_bucket" "chartmuseum" {
  bucket = "gitops-helm-summit-chartmuseum"
  acl    = "private"

  tags = {
    Name        = "gitops-helm-summit-chartmuseum"
    Environment = "Dev"
  }
}
