resource "aws_apigatewayv2_integration" "pedido_ms_historico" {
  api_id = aws_apigatewayv2_api.main.id
  integration_type   = "HTTP_PROXY"
  integration_method = "ANY"
  integration_uri    = "${var.aws_pedido_ms_elb}/Pedido/historico"
  connection_type    = "INTERNET"
}

resource "aws_apigatewayv2_route" "pedido_ms_private_route" {
  api_id    = aws_apigatewayv2_api.main.id
  route_key = "GET /pedido/historico"
  target = "integrations/${aws_apigatewayv2_integration.pedido_ms_historico.id}"
  authorization_type = "JWT"
  authorizer_id = aws_apigatewayv2_authorizer.api_authorize.id
}


resource "aws_apigatewayv2_integration" "pedido_ms" {
  api_id = aws_apigatewayv2_api.main.id
  integration_type   = "HTTP_PROXY"
  integration_method = "ANY"
  integration_uri    = "${var.aws_pedido_ms_elb}"
  connection_type    = "INTERNET"
}

resource "aws_apigatewayv2_route" "pedido_ms_public_route" {
  api_id    = aws_apigatewayv2_api.main.id
  route_key = "ANY /Pedido"
  target = "integrations/${aws_apigatewayv2_integration.pedido_ms.id}"
}


resource "aws_apigatewayv2_integration" "pedido_ms_proxy" {
  api_id = aws_apigatewayv2_api.main.id
  integration_type   = "HTTP_PROXY"
  integration_method = "ANY"
  integration_uri    = "${var.aws_pedido_ms_elb}/{proxy}"
  connection_type    = "INTERNET"
}

resource "aws_apigatewayv2_route" "pedido_ms_public_route_proxy" {
  api_id    = aws_apigatewayv2_api.main.id
  route_key = "ANY /Pedido/{proxy+}"
  target = "integrations/${aws_apigatewayv2_integration.pedido_ms_proxy.id}"
}


resource "aws_apigatewayv2_integration" "pedido_ms_categoria" {
  api_id = aws_apigatewayv2_api.main.id
  integration_type   = "HTTP_PROXY"
  integration_method = "ANY"
  integration_uri    = "${var.aws_pedido_ms_elb}/Categoria"
  connection_type    = "INTERNET"
}

resource "aws_apigatewayv2_route" "pedido_ms_public_route_categaria" {
  api_id    = aws_apigatewayv2_api.main.id
  route_key = "ANY /Categoria"
  target = "integrations/${aws_apigatewayv2_integration.pedido_ms_categoria.id}"
}


resource "aws_apigatewayv2_integration" "pedido_ms_produto" {
  api_id = aws_apigatewayv2_api.main.id
  integration_type   = "HTTP_PROXY"
  integration_method = "ANY"
  integration_uri    = "${var.aws_pedido_ms_elb}/Produto"
  connection_type    = "INTERNET"
}

resource "aws_apigatewayv2_route" "pedido_ms_public_route_produto" {
  api_id    = aws_apigatewayv2_api.main.id
  route_key = "ANY /Produto"
  target = "integrations/${aws_apigatewayv2_integration.pedido_ms_produto.id}"
}

resource "aws_apigatewayv2_integration" "pedido_ms_produto_proxy" {
  api_id = aws_apigatewayv2_api.main.id
  integration_type   = "HTTP_PROXY"
  integration_method = "ANY"
  integration_uri    = "${var.aws_pedido_ms_elb}/Produto/{proxy}"
  connection_type    = "INTERNET"
}

resource "aws_apigatewayv2_route" "pedido_ms_public_route_produto_proxy" {
  api_id    = aws_apigatewayv2_api.main.id
  route_key = "ANY /Produto/{proxy+}"
  target = "integrations/${aws_apigatewayv2_integration.pedido_ms_produto_proxy.id}"
}