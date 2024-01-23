# resource "aws_apigatewayv2_integration" "auth_lambda" {
#   api_id             = var.apigateway_id
#   integration_uri    = aws_lambda_function.auth_lambda.invoke_arn
#   integration_type   = "AWS_PROXY"
#   integration_method = "POST"
# }

# resource "aws_apigatewayv2_route" "post_auth" {
#   api_id    = var.apigateway_id
#   route_key = "POST /auth"
#   target    = "integrations/${aws_apigatewayv2_integration.auth_lambda.id}"
# }


