output "s3_website_url" {
  value = aws_s3_bucket_website_configuration.static_hosting.website_endpoint
}

output "lambda_function_name" {
  value = aws_lambda_function.weather_lambda.function_name
}

output "api_gateway_url" {
  value = aws_apigatewayv2_api.weather_api.api_endpoint
}

output "cloudfront_domain" {
  value = aws_cloudfront_distribution.cdn.domain_name
}
