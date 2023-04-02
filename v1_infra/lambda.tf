data "archive_file" "tr_lambda" {
  type        = "zip"
  source_dir  = "./lambda/src"
  output_path = "./lambda/upload/lambda.zip"
}

resource "aws_lambda_function" "tr_lambda" {
  filename         = data.archive_file.tr_lambda.output_path
  function_name    = "${var.prefix}_tr_lambda"
  role             = aws_iam_role.tr_lambda_role.arn
  handler          = "tr_lambda.handler"
  source_code_hash = data.archive_file.tr_lambda.output_base64sha256
  runtime          = "python3.8"
  timeout          = 29
  environment {
    variables = {
      TABLE_NAME = aws_dynamodb_table.arexa_list.name
    }
  }
}

output "tr_lambda-invoke-arn" {
  value = aws_lambda_function.tr_lambda.invoke_arn
}