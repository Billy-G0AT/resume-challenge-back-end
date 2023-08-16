#* Dynamodb Table
resource "aws_dynamodb_table" "hcl-table" {
  name         = var.table
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "sitename"
  attribute {
    name = "sitename"
    type = "S"
  }
}

