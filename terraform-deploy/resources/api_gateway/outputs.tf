output "api_gateway_id" {
  value = aws_apigatewayv2_api.api.id
  description = "The id of the API Gateway"
}