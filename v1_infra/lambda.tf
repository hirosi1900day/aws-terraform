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
      SLACK_CHANEL = "#test2"
      WEB_HOOK_URL = aws_ssm_parameter.foo.name
    }
  }
}

resource "aws_ssm_parameter" "foo" {
  name  = "foo"
  type  = "String"
  value = "https://hooks.slack.com/services/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"
}
# 更新方法  aws ssm put-parameter --name "foo" --type "String" --value "hello" --overwrite --profile private

resource "aws_cloudwatch_log_subscription_filter" "my_subscription_filter" {
  name            = "my_subscription_filter"
  log_group_name  = "/aws/rds/instance/database-1/error"
  filter_pattern  = "ERROR"
  destination_arn = aws_lambda_function.tr_lambda.arn
  depends_on      = [aws_lambda_permission.logging]
}

resource "aws_lambda_permission" "logging" {
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.tr_lambda.function_name
  principal     = "logs.ap-northeast-1.amazonaws.com"
  source_arn    = "arn:aws:logs:ap-northeast-1:572919087216:log-group:/aws/rds/instance/database-1/error:*"
}


# resource "aws_lambda_event_source_mapping" "example" {
#   event_source_arn  = "arn:aws:logs:ap-northeast-1:572919087216:log-group:/aws/rds/instance/database-1/error:*"
#   function_name     = aws_lambda_function.tr_lambda.arn
#   starting_position = "LATEST"

#   batch_size = 100
#   enabled    = true
# }

output "tr_lambda-invoke-arn" {
  value = aws_lambda_function.tr_lambda.invoke_arn
}