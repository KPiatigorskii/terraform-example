terraform {
  backend "s3" {
  }
}

provider "aws" {
  region = var.region
}

module "sqs" {
  source = "./resources/sqs"
  stage = var.environment
}

module "s3" {
  source = "./resources/s3"
  stage = var.environment
}

module "lambda" {
  source = "./resources/lambda"
  stage = var.environment
}

module "api_gateway" {
  region = var.region
  manager_plan_function_arn   = module.lambda.manager_plan_function_arn
  # we need to pass and add here all lambdas which we need to integrate to api_gateway 
  stage = var.environment
  source = "./resources/api_gateway"
}

module "dynamodb" {
  source = "./resources/dynamodb"
  stage = var.environment
}

module "frontend"{
  source = "./resources/s3_frontend"
  stage = var.environment
}

module "cognito" {
  source = "./resources/cognito"
  stage = var.environment
}