# resource "aws_cloudwatch_log_metric_filter" "firehose_erorr" {
#   name           = "FirehoseErorrCount"
#   pattern        = ""
#   log_group_name = aws_cloudwatch_log_group.firehose_log.name

#   metric_transformation {
#     name      = "EventCount"
#     namespace = "Firehose"
#     value     = "1"
#   }
# }

# resource "aws_cloudwatch_metric_alarm" "firehose_erorr" {
#   alarm_name          = "FirehoseErorr"
#   comparison_operator = "GreaterThanThreshold"
#   evaluation_periods  = "1"
#   metric_name         = "EventCount"
#   namespace           = "Firehose"
#   period              = "300" # 5 min
#   statistic           = "SampleCount"
#   threshold           = "0"
#   alarm_actions       = [aws_sns_topic.slack.arn]
#   ok_actions          = [aws_sns_topic.slack.arn]
# }