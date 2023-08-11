#* Subdomain Bucket
resource "aws_s3_bucket" "hcl-subdomain-bucket" {
  bucket = var.subdomain
}

#* Redirect to Domain Bucket
resource "aws_s3_bucket_website_configuration" "hcl-subdomain-webconfig" {
  bucket = var.subdomain
  redirect_all_requests_to {
    host_name = var.domain
    protocol  = "http"
  }
}

#* Subdomain Bucket Allow Public Access
resource "aws_s3_bucket_public_access_block" "hcl-subdomain-bucket-public-access" {
  bucket                  = var.subdomain
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

#* Subdomain Bucket Policy Document
data "aws_iam_policy_document" "hcl-subdomain-policy-doc" {
  statement {
    sid       = "PublicReadGetObject"
    effect    = "Allow"
    actions   = ["s3:GetObject"]
    resources = ["arn:aws:s3:::${var.subdomain}/*"]
    principals {
      identifiers = ["*"]
      type        = "*"
    }
  }
}

#* Subdomain Bucket Policy
resource "aws_s3_bucket_policy" "hcl-subdomain-policy" {
  bucket = var.subdomain
  policy = data.aws_iam_policy_document.hcl-subdomain-policy-doc.json
}



