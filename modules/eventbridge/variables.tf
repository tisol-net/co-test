variable weather_retrieve_cron {
    type        = string
    description = "Cron Schedule for Ingestion"
    default     = "cron(0 17 * * * *)"
}

variable weather_retrieve_lambda_arn {
    type        = string
    description = "ARN of the Ingest Lambda Function"
}

variable weather_retrive_role_arn {
    type        = string
    description = "ARN of the IAM Role associated with the Lambda"
}
