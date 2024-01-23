provider "aws" {
  region = "us-east-1"
}

terraform {
  required_providers {
    aws = "~> 5.0"
  }

  backend "s3" {
    bucket = "fiap-restaurant-terraform-ms"
    key    = "fiap-restaurant-ms-api-gateway"
    region = "us-east-1"
  }
}

module "eks" {
  source       = "./modules/eks"
  cluster_name = "fiap-restaurant-g-cluster"
}

module "api-gateway" {
  source          = "./modules/api-gateway"
  jwt_audience    = module.cognito.user_pool_client_id
  jwt_issuer      = module.cognito.user_pool_endpoint
  auth_lambda_arn = module.lambda.auth_lambda_arn
  aws_subnet      = module.eks.aws_subnet
  eks_cluster     = module.eks.eks_cluster
  aws_eks_elb     = var.aws_eks_elb
}

module "cognito" {
  source = "./modules/cognito"
}

module "lambda" {
  source                   = "./modules/lambda"
  lambda_bucket_id         = module.s3.lambda_bucket_id
  apigateway_id            = module.api-gateway.apigateway_id
  apigateway_execution_arn = module.api-gateway.apigateway_execution_arn
  aws_subnet               = module.eks.aws_subnet
  aws_eks_elb              = var.aws_eks_elb
}

module "s3" {
  source = "./modules/s3"
}
