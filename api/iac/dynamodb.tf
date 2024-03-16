resource "aws_dynamodb_table" "dynamodb_table0" {
  for_each                    = { for name in var.mode : name => name }
  tags                        = merge(var.tags, {})
  stream_enabled              = false
  name                        = "${var.table0_name}-${each.key}"
  hash_key                    = "Number"
  deletion_protection_enabled = false
  billing_mode                = "PAY_PER_REQUEST"

  attribute {
    type = "N"
    name = "Number"
  }
}

resource "aws_dynamodb_table" "dynamodb_table1" {
  for_each                    = { for name in var.mode : name => name }
  tags                        = merge(var.tags, {})
  stream_enabled              = false
  name                        = "${var.table1_name}-${each.key}"
  hash_key                    = "Number"
  deletion_protection_enabled = false
  billing_mode                = "PAY_PER_REQUEST"

  attribute {
    type = "N"
    name = "Number"
  }
}

resource "aws_dynamodb_table" "dynamodb_table2" {
  for_each                    = { for name in var.mode : name => name }
  tags                        = merge(var.tags, {})
  stream_enabled              = false
  name                        = "${var.table2_name}-${each.key}"
  hash_key                    = "Number"
  deletion_protection_enabled = false
  billing_mode                = "PAY_PER_REQUEST"

  attribute {
    type = "N"
    name = "Number"
  }
}