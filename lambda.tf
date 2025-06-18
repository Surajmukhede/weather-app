resource "aws_lambda_function" "weather_lambda" {
  function_name = var.lambda_function_name
  role          = aws_iam_role.lambda_exec.arn
  handler       = "index.handler"
  runtime       = "nodejs18.x"
  filename      = "lambda/weather_lambda.zip"
  source_code_hash = filebase64sha256("lambda/weather_lambda.zip")
  
  environment {
    variables = {
      WEATHER_API_KEY = var.weather_api_key
    }
  }
}
