resource "aws_lambda_function" "weather_etl" {
  function_name    = "weather-etl"
  filename         = "weather-etl-payload.zip"
  source_code_hash = filebase64sha256("weather-etl-payload.zip")
  handler          = "index.handler"
  role             = aws_iam_role.lambda_assume.arn
  runtime          = "python3.10"
  vpc_config {
    subnet_ids = [aws_subnet.example.id]
    security_group_ids = [aws_security_group.example.id]
  }
}