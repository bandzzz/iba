resource "aws_dynamodb_table" "bandzzz-dynamodb-lock-table" {
  name         = "bandzzz-dynamodb-lock-table"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
