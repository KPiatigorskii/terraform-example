variable "environment_variables" {
  type        = map(string)
  default = {}
}

variable "timeout" {
  type        = number
  default = 5
}

variable "function_name" {
  description = "The name of the Lambda function"
  type        = string
}

variable "lambda_source_path" {
  description = "The path to the Lambda function source file"
  type        = string
}

variable "lambda_output_path" {
  description = "The output path for the Lambda function deployment package"
  type        = string
}

variable "role_arn" {
  description = "The arn of the IAM role"
  type        = string
  default = null
}

variable "api_gateway_name" {
  description = "The name of the API Gateway"
  type        = string
  default = null
}

variable "api_gateway_integration" {
  description = "Whether or not to create the API Gateway resources"
  type        = bool
  default     = false
}

variable "api_gateway_id" {
    description = "ApiGateway id from api_gateway module"
    type        = string
    default     = null
}