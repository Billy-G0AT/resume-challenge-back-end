#* Domain Bucket
resource "aws_s3_bucket" "this" {
  bucket = var.domain
}

#* Domain Bucket Index File
resource "aws_s3_bucket_website_configuration" "this" {
  bucket = var.domain
  index_document {
    suffix = "indexx.html"
  }
}

#* Domain Bucket Allow Public Access 
resource "aws_s3_bucket_public_access_block" "this" {
  bucket                  = var.domain
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

#* Domain Bucket Policy Document
data "aws_iam_policy_document" "this" {
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
resource "aws_s3_bucket_policy" "this" {
  bucket = var.domain
  policy = data.aws_iam_policy_document.this.json
}
