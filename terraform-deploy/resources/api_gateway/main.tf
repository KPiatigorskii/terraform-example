
resource "aws_apigatewayv2_api" "api" {
  name          = "${var.stage}-${var.api_gateway_name}"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_route" "route" {
  api_id    = aws_apigatewayv2_api.api.id
  route_key = "ANY /{proxy+}"
  target    = "integrations/${aws_apigatewayv2_integration.proxy.id}"
}

resource "aws_apigatewayv2_integration" "proxy" {
  api_id           = aws_apigatewayv2_api.api.id
  integration_type = "AWS_PROXY"
  integration_uri  = "arn:aws:apigateway:${var.region}:lambda:path/2015-03-31/functions/${var.manager_plan_function_arn}/invocations"
}

resource "aws_apigatewayv2_stage" "stage" {
  api_id      = aws_apigatewayv2_api.api.id
  name        = var.stage
  auto_deploy = true
}

output "invoke_url" {
  value = aws_apigatewayv2_stage.stage.invoke_url
}
