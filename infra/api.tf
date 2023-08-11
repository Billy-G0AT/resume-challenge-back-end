#* API
resource "aws_apigatewayv2_api" "hcl-api" {
  name          = var.api
  protocol_type = "HTTP"
  cors_configuration {
    allow_credentials = false
    allow_headers = [
      "authorization",
      "content-type",
    ]
    allow_methods = [
      "GET",
    ]
    allow_origins = [
      "https://${var.domain}",
      "https://${var.subdomain}",
    ]
    expose_headers = []
    max_age        = 0
  }
}

#* API Stage
resource "aws_apigatewayv2_stage" "hcl-api-stage" {
  api_id      = aws_apigatewayv2_api.hcl-api.id
  name        = "dev"
  auto_deploy = true
}

#* API Integration
resource "aws_apigatewayv2_integration" "hcl-api-integration" {
  api_id                 = aws_apigatewayv2_api.hcl-api.id
  integration_uri        = aws_lambda_function.hcl-lambda.arn
  integration_type       = "AWS_PROXY"
  integration_method     = "POST"
  payload_format_version = "2.0"
}

#* API Route
resource "aws_apigatewayv2_route" "hcl-api-route" {
  api_id    = aws_apigatewayv2_api.hcl-api.id
  route_key = "GET /${var.function}"
  target    = "integrations/${aws_apigatewayv2_integration.hcl-api-integration.id}"
}

#* Lambda Permission To Get Invoked By API
resource "aws_lambda_permission" "hcl-api-permission" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = var.function
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.hcl-api.execution_arn}/*/*"
}


