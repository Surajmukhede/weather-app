variable "region" {
  description = "AWS region"
  type        = string
}

variable "bucket_name" {
  description = "S3 bucket name for static site"
  type        = string
}

variable "lambda_name" {
  description = "Name for the Lambda function"
  type        = string
}

variable "lambda_zip_path" {
  description = "Path to the zipped Lambda function"
  type        = string
}

variable "cloudfront_comment" {
  description = "Comment for CloudFront distribution"
  type        = string
  default     = "Weather App CloudFront"
}
variable "lambda_function_name" {
  default = "weatherLambdaFunction"
}

variable "weather_api_key" {
  description = "Your OpenWeatherMap API key"
  type        = string
  sensitive   = true
}

