resource "aws_lambda_function" "weather_retrive" {
  function_name    = "weather-retrieve"
  filename         = "weather-retrieve-payload.zip"
  source_code_hash = filebase64sha256("weather-retrieve-payload.zip")
  handler          = "index.handler"
  role             = aws_iam_role.lambda_assume.arn
  runtime          = "python3.10"
  vpc_config {
    subnet_ids = [aws_subnet.example.id]
    security_group_ids = [aws_security_group.example.id]
  }
}