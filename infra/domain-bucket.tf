#* Domain Bucket
resource "aws_s3_bucket" "hcl-domain-bucket" {
  bucket = var.domain
}

#* Domain Bucket Index File
resource "aws_s3_bucket_website_configuration" "hcl-domain-webconfig" {
  bucket = var.domain
  index_document {
    suffix = "index.html"
  }
}

#* Domain Bucket Allow Public Access 
resource "aws_s3_bucket_public_access_block" "hcl-domain-bucket-public-access" {
  bucket                  = var.domain
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

#* Domain Bucket Policy Document
data "aws_iam_policy_document" "hcl-domain-policy-doc" {
  statement {
    sid       = "PublicReadGetObject"
    effect    = "Allow"
    actions   = ["s3:GetObject"]
    resources = ["arn:aws:s3:::${var.domain}/*"]
    principals {
      identifiers = ["*"]
      type        = "*"
    }
  }
}

#* Domain Bucket Policy
resource "aws_s3_bucket_policy" "hcl-domain-policy" {
  bucket = var.domain
  policy = data.aws_iam_policy_document.hcl-domain-policy-doc.json
}


