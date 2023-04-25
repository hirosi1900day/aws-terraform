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
  runtime          = "python3.9"
  timeout          = 29
  environment {
    variables = {
      TABLE_NAME = "test"
    }
  }
}

resource "aws_cloudwatch_log_subscription_filter" "my_subscription_filter" {
  name            = "my_subscription_filter"
  role_arn        = aws_iam_role.lambda_role.id
  log_group_name  = "/aws/rds/instance/database-1/error"
  filter_pattern  = "ERROR"
  destination_arn = "arn:aws:lambda:ap-northeast-1:572919087216:function:sample1_tr_lambda"
}

output "tr_lambda-invoke-arn" {
  value = aws_lambda_function.tr_lambda.invoke_arn
}