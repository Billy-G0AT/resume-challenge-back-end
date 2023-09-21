#* Dynamodb Table
resource "aws_dynamodb_table" "this" {
  name                        = var.table
  deletion_protection_enabled = true
  billing_mode                = "PAY_PER_REQUEST"
  hash_key                    = "sitename"
  attribute {
    name = "sitename"
    type = "S"
  }
}
