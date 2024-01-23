resource "aws_apigatewayv2_api" "main" {
  name          = "fiap-restaurant_api_gw"
  protocol_type = "HTTP"
  
  tags = {
    fiap = "restaurant-ms",
  }
}

resource "aws_apigatewayv2_stage" "production" {
  api_id      = aws_apigatewayv2_api.main.id
  name        = "production"
  auto_deploy = true
  
  tags = {
    fiap = "restaurant-ms",
  }

  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.api_gw.arn

    format = jsonencode({
      requestId               = "$context.requestId"
      sourceIp                = "$context.identity.sourceIp"
      requestTime             = "$context.requestTime"
      protocol                = "$context.protocol"
      httpMethod              = "$context.httpMethod"
      resourcePath            = "$context.resourcePath"
      routeKey                = "$context.routeKey"
      status                  = "$context.status"
      responseLength          = "$context.responseLength"
      integrationErrorMessage = "$context.integrationErrorMessage"
      }
    )
  }
}

resource "aws_cloudwatch_log_group" "api_gw" {
  name = "/aws/api_gw/${aws_apigatewayv2_api.main.name}"
  retention_in_days = 30
  
  tags = {
    fiap = "restaurant-ms",
  }
}

resource "aws_apigatewayv2_authorizer" "api_authorize" {
  api_id           = aws_apigatewayv2_api.main.id
  authorizer_type  = "JWT"
  identity_sources = ["$request.header.Authorization"]
  name             = "cognito-authorizer"

  jwt_configuration {
    audience = [var.jwt_audience]
    issuer   = "https://${var.jwt_issuer}"
  }
}

resource "aws_apigatewayv2_integration" "auth_lambda" {
  api_id             = aws_apigatewayv2_api.main.id
  integration_uri    = var.auth_lambda_arn
  integration_type   = "AWS_PROXY"
  integration_method = "POST"
}

resource "aws_apigatewayv2_route" "auth_route" {
  api_id    = aws_apigatewayv2_api.main.id
  route_key = "POST /auth"
  target = "integrations/${aws_apigatewayv2_integration.auth_lambda.id}"
}


resource "aws_apigatewayv2_vpc_link" "eks" {
  name               = "eks"
  security_group_ids = [var.eks_cluster.vpc_config[0].cluster_security_group_id]
  subnet_ids = [
    var.aws_subnet.subnet_private_1a,
    var.aws_subnet.subnet_private_1b,
  ]
}

resource "aws_apigatewayv2_integration" "eks" {
  api_id = aws_apigatewayv2_api.main.id
  integration_type   = "HTTP_PROXY"
  integration_uri    = var.aws_eks_elb

  connection_type    = "INTERNET"
  integration_method = "ANY"
  # connection_id      = aws_apigatewayv2_vpc_link.eks.id
}

resource "aws_apigatewayv2_route" "private_route" {
  api_id    = aws_apigatewayv2_api.main.id
  route_key = "GET /pedido/historico"
  target = "integrations/${aws_apigatewayv2_integration.eks.id}"
  authorization_type = "JWT"
  authorizer_id = aws_apigatewayv2_authorizer.api_authorize.id
}

resource "aws_apigatewayv2_route" "public_route" {
  api_id    = aws_apigatewayv2_api.main.id
  route_key = "$default"
  target = "integrations/${aws_apigatewayv2_integration.eks.id}"
}
