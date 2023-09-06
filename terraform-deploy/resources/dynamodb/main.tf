resource "aws_dynamodb_table" "event" {
  name           = "${var.stage}-${var.table_name}"
  billing_mode   = "PAY_PER_REQUEST"

  attribute {
    name = var.hash_key_name
    type = var.hash_key_type
  }

  hash_key = var.hash_key_name
}


