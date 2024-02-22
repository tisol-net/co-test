resource "aws_scheduler_schedule" "weather_trigger" {
  name       = "trigger-schedule"
  group_name = "ingest"

  flexible_time_window {
    mode = "OFF"
  }

  schedule_expression = var.weather_retrieve_cron

  target {
    arn      = var.weather_retrieve_lambda_arn
    role_arn = var.weather_retrive_role_arn
  }
}
