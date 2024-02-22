output lambda_trigger {
  description = "S3 Trigger Funnction"
  value       = aws.lambda_function.s3_trigger
}

output weather_retrieve_lambda_arn {
  value       = aws.lambda_function.weather_retrive.arn
}