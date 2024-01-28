resource "aws_apigatewayv2_integration" "producao_ms" {
  api_id = aws_apigatewayv2_api.main.id
  integration_type   = "HTTP_PROXY"
  integration_uri   = "${var.aws_producao_ms_elb}/Pedido/AtualizarStatus/{proxy}"
  connection_type    = "INTERNET"
  integration_method = "ANY"
}

resource "aws_apigatewayv2_route" "producao_ms_public_route" {
  api_id    = aws_apigatewayv2_api.main.id
  route_key = "ANY /Pedido/AtualizarStatus/{proxy+}"
  target = "integrations/${aws_apigatewayv2_integration.producao_ms.id}"
}