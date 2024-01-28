resource "aws_apigatewayv2_integration" "pagamento_ms_webhook" {
  api_id = aws_apigatewayv2_api.main.id
  integration_type   = "HTTP_PROXY"
  integration_uri    = "${var.aws_pagamento_ms_elb}/WebHook/{proxy}"

  connection_type    = "INTERNET"
  integration_method = "ANY"
}

resource "aws_apigatewayv2_route" "pagamento_ms_public_route" {
  api_id    = aws_apigatewayv2_api.main.id
  route_key = "ANY /WebHook/{proxy+}"
  target = "integrations/${aws_apigatewayv2_integration.pagamento_ms_webhook.id}"
}


resource "aws_apigatewayv2_integration" "pagamento_ms" {
  api_id = aws_apigatewayv2_api.main.id
  integration_type   = "HTTP_PROXY"
  integration_uri    = "${var.aws_pagamento_ms_elb}/Pagamento/{proxy}"

  connection_type    = "INTERNET"
  integration_method = "ANY"
}

resource "aws_apigatewayv2_route" "pagamento_ms_public_route_pagamento" {
  api_id    = aws_apigatewayv2_api.main.id
  route_key = "ANY /Pagamento/{proxy+}"
  target = "integrations/${aws_apigatewayv2_integration.pagamento_ms.id}"
}


resource "aws_apigatewayv2_integration" "pagamento_ms_client" {
  api_id = aws_apigatewayv2_api.main.id
  integration_type   = "HTTP_PROXY"
  integration_uri    = "${var.aws_pagamento_ms_elb}/Cliente/{proxy}"

  connection_type    = "INTERNET"
  integration_method = "ANY"
}

resource "aws_apigatewayv2_route" "pagamento_ms_public_route_client" {
  api_id    = aws_apigatewayv2_api.main.id
  route_key = "ANY /Cliente/{proxy+}"
  target = "integrations/${aws_apigatewayv2_integration.pagamento_ms_client.id}"
}