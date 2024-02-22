data aws_iam_role lambda_assume {
  arn = aws_iam_role.lambda_access.arn
}

resource "aws_scheduler_schedule" "weather_trigger" {
  name       = "trigger-schedule"
  group_name = "ingest"

  flexible_time_window {
    mode = "OFF"
  }

  schedule_expression = var.weather_retrieve_cron

  target {
    arn      = var.weather_retrieve_lambda_arn
    role_arn = data.aws_iam_role.lambda_assume
  }
}
