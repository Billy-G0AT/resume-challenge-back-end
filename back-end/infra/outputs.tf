output "api_url" {
  value = join("", [
    aws_apigatewayv2_stage.this.invoke_url,
    "/",
    aws_apigatewayv2_api.this.name,
  ])
}