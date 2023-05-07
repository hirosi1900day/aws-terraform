
variable "prefix" {
  type    = string
  default = "sample1"
}

variable "name" {
  type    = string
  default = "eks_network"
}

variable "cidr" {
  type    = string
  default = "10.3.0.0/16"
}

variable "eks_name" {
  type    = string
  default = "test_eks"
}

# テスト
#   arexa_list_table-arn = module.dynamodb.arexa_list_table.arn
# }

# module "lambda" {
#   source                = "./modules/lambda"
#   prefix                = "sample1"
#   arexa_list_table-name = module.dynamodb.arexa_list_table.name
#   tr_lambda_role-arn    = module.iam.tr_lambda_role-arn
# }

# module "eks_network" {
#   source = "./modules/eks_network"
#   name   = "eks_network"
#   cidr   = "10.3.0.0/16"
# }