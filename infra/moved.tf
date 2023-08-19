#* api.tf
moved {
  from = aws_apigatewayv2_api.hcl-api
  to = aws_apigatewayv2_api.this
}

moved {
  from = aws_apigatewayv2_stage.hcl-api-stage
  to = aws_apigatewayv2_stage.this
}

moved {
  from = aws_apigatewayv2_integration.hcl-api-integration
  to = aws_apigatewayv2_integration.this
}

moved {
  from = aws_apigatewayv2_route.hcl-api-route
  to = aws_apigatewayv2_route.this
}

moved {
  from = aws_lambda_permission.hcl-api-permission
  to = aws_lambda_permission.this
}
# --------------------------------------------------------
#* domain-bucket.terraform {
  
moved {
  from = aws_s3_bucket.hcl-domain-bucket
  to = aws_s3_bucket.this
}

moved {
  from = aws_s3_bucket_website_configuration.hcl-domain-webconfig
  to = aws_s3_bucket_website_configuration.this
}

moved {
  from = aws_s3_bucket_public_access_block.hcl-domain-bucket-public-access
  to = aws_s3_bucket_public_access_block.this
}

moved {
  from = aws_iam_policy_document.hcl-domain-policy-doc
  to = aws_iam_policy_document.this
}

moved {
  from = aws_s3_bucket_policy.hcl-domain-policy
  to = aws_s3_bucket_policy.this
}