resource "aws_dynamodb_table" "occr_table" {
  name           = "occurance-table"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "id"

  attribute {
    name = "id"
    type = "S"
  }

  # Add more attributes as needed
  # Example:
  # attribute {
  #   name = "name"
  #   type = "S"
  # }
}
