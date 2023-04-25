

resource "aws_iam_role" "tr_lambda_role" {
  name = "${var.prefix}_tr_lambda_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "tr_lambda_role_policy_attach" {
  role       = aws_iam_role.tr_lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

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

# resource "aws_iam_role" "lambda_role" {
#   name = "lambda_execution_role"

#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Action = "sts:AssumeRole"
#         Effect = "Allow"
#         Principal = {
#           Service = "lambda.amazonaws.com"
#         }
#       }
#     ]
#   })
# }

resource "aws_iam_role_policy" "lambda_policy" {
  name = "lambda_execution_policy"
  role = aws_iam_role.tr_lambda_role.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "kms:Decrypt"
        ]
        Resource = "*"
      }
    ]
  })
}

# resource "aws_iam_role_policy_attachment" "lambda_role_policy" {
#   policy_arn = aws_iam_role_policy.lambda_policy.id
#   role       = aws_iam_role.lambda_role.name
# }

output "tr_lambda_role-arn" {
  value = aws_iam_role.tr_lambda_role.arn
}