resource "aws_lambda_function" "lambda_function" {
  function_name    = var.function_name
  role             = var.role_arn
  handler          = "dist/main.handler"
  runtime          = "nodejs18.x"
  filename         = var.lambda_output_path
  timeout          = var.timeout
  source_code_hash = filebase64sha256(var.lambda_output_path)
  environment {
    variables = var.environment_variables
  }
}