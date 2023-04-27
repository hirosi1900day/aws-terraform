data "archive_file" "tr_lambda" {
  type        = "zip"
  source_dir  = "./lambda/src"
  output_path = "./lambda/upload/lambda.zip"
}

resource "aws_lambda_function" "tr_lambda" {
  filename         = data.archive_file.tr_lambda.output_path
  function_name    = "${var.prefix}_tr_lambda"
  role             = aws_iam_role.tr_lambda_role.arn
  handler          = "lambda_function.lambda_handler"
  source_code_hash = data.archive_file.tr_lambda.output_base64sha256
  runtime          = "python3.9"
  timeout          = 29
  environment {
    variables = {
      TABLE_NAME            = "test"
      GITHUB_TOKEN_SSM_NAME = aws_ssm_parameter.foo.name
    }
  }
}

resource "aws_ssm_parameter" "foo" {
  name  = "foo"
  type  = "String"
  value = "あとで変更する"
}
# 更新方法  aws ssm put-parameter --name "foo" --type "String" --value "hello" --overwrite --profile private

# resource "aws_cloudwatch_log_subscription_filter" "my_subscription_filter" {
#   name            = "my_subscription_filter"
#   log_group_name  = "/aws/rds/instance/database-1/error"
#   filter_pattern  = "ERROR"
#   destination_arn = "arn:aws:lambda:ap-northeast-1:572919087216:function:sample1_tr_lambda"
# }

resource "aws_lambda_event_source_mapping" "example" {
  event_source_arn  = aws_dynamodb_table.example.stream_arn
  function_name     = aws_lambda_function.example.arn
  starting_position = "LATEST"
}

output "tr_lambda-invoke-arn" {
  value = aws_lambda_function.tr_lambda.invoke_arn
}