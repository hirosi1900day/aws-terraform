variable "prefix" {
  type = string
}

resource "aws_dynamodb_table" "arexa2_list" {
  name         = "${var.prefix}_arexa2_list"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "arexa2Id"
  attribute {
    name = "arexa2Id"
    type = "S"
  }
}

resource "aws_dynamodb_table_item" "arexa2_list_item" {
  table_name = aws_dynamodb_table.arexa2_list.name
  hash_key   = "arexa2Id"
  item = jsonencode({
    arexa2Id = {
      S = "a00000110"
    },
    FirstName = {
      S = "Taro"
    },
    LastName = {
      S = "Momo"
    },
    Office = {
      S = "Nagoya"
    }
  })
}

output "arexa2_list_table" {
  value = aws_dynamodb_table.arexa2_list
}