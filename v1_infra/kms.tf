resource "aws_kms_key" "demo" {
  description             = "for demo"
  key_usage               = "ENCRYPT_DECRYPT"
  enable_key_rotation     = true
  deletion_window_in_days = 7
}


9
10
11
resource "aws_kms_key" "demo" {
  description             = "for demo"
  key_usage               = "ENCRYPT_DECRYPT"
  enable_key_rotation     = true
  deletion_window_in_days = 7
}

resource "aws_kms_alias" "demo" {
  name          = "alias/demo-alias"
  target_key_id = aws_kms_key.demo.id
}