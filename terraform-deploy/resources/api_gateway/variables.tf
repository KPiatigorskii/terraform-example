variable "api_gateway_name" {
  description = "api_gateway_name"
  type        = string
  default = "terraform-gateway"
}

variable "manager_plan_function_arn" {}
variable "stage" {}
variable "region" {}
