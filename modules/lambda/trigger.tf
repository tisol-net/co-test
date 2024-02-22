data aws_iam_role lambda_assume {
  arn = aws_iam_role.lambda_access.arn
}

resource "aws_lambda_function" "weather_etl" {
  function_name    = "trigger"
  filename         = "weather-trigger-payload.zip"
  source_code_hash = filebase64sha256("weather-trigger-payload.zip")
  handler          = "index.handler"
  role             = data.aws_iam_role.lambda_assume.arn
  runtime          = "python3.10"
  vpc_config {
    subnet_ids = [var.subnet_id]
    security_group_ids = [var.security_group_id]
  }
}