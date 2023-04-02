

# resource "aws_iam_role" "tr_lambda_role" {
#   name = "${var.prefix}_tr_lambda_role"
#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Action = "sts:AssumeRole"
#         Effect = "Allow"
#         Sid    = ""
#         Principal = {
#           Service = "lambda.amazonaws.com"
#         }
#       },
#     ]
#   })
# }

# resource "aws_iam_role_policy_attachment" "tr_lambda_role_policy_attach" {
#   role       = aws_iam_role.tr_lambda_role.name
#   policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
# }

# resource "aws_iam_role_policy" "tr_lambda_role_policy_policy" {
#   name = "${var.prefix}_tr_lambda_policy"
#   role = aws_iam_role.tr_lambda_role.id
#   policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Effect = "Allow"
#         Action = [
#           "dynamodb:GetItem"
#         ]
#         Resource = [
#           aws_dynamodb_table.arexa_list.arn
#         ]
#       }
#     ]
#   })
# }

# output "tr_lambda_role-arn" {
#   value = aws_iam_role.tr_lambda_role.arn
# }