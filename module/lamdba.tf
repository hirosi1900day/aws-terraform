# variable "prefix" {
#   type = string
#   default = "arexa"
# }

# variable "arexa_list_table-name" {
#   type = string
#   default = "arexa_list_table"
# }

# variable "tr_lambda_role-arn" {
#   type = string
#   default = "tr_lambda_role-arn"
# }

# data "archive_file" "tr_lambda" {
#   type        = "zip"
#   source_dir  = "../module/src/lambda.tf"
#   output_path = "../module/src/upload/lambda.zip"
# }

# resource "aws_lambda_function" "tr_lambda" {
#   filename         = data.archive_file.tr_lambda.output_path
#   function_name    = "${var.prefix}_tr_lambda"
#   role             = var.tr_lambda_role-arn
#   handler          = "tr_lambda.handler"
#   source_code_hash = data.archive_file.tr_lambda.output_base64sha256
#   runtime          = "python3.8"
#   timeout          = 29
#   environment {
#     variables = {
#       TABLE_NAME = var.arexa_list_table-name
#     }
#   }
# }

# output "tr_lambda-invoke-arn" {
#   value = aws_lambda_function.tr_lambda.invoke_arn
# }