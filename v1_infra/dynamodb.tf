variable "prefix" {
  type = string
  default = "arexa"
}

resource "aws_dynamodb_table" "arexa_list" {
  name         = "${var.prefix}_arexa_list"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "arexaId"
  attribute {
    name = "arexaId"
    type = "S"
  }
}

resource "aws_dynamodb_table_item" "arexa_list_item" {
  table_name = aws_dynamodb_table.arexa_list.name
  hash_key   = "arexaId"
  item = jsonencode({
    arexaId = {
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

output "arexa_list_table" {
  value = aws_dynamodb_table.arexa_list
}