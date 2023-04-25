resource "aws_kms_key" "demo" {
  description             = "for demo"
  key_usage               = "ENCRYPT_DECRYPT"
  enable_key_rotation     = true
  deletion_window_in_days = 7
}