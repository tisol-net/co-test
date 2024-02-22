variable weather_landing_bucket {
    type        = string
    description = "S3 Landing bucket"
    default     = "weather_landing"
}

variable weather_transformed_bucket {
    type        = string
    description = "S3 transformed ETL"
    default     = "weather_transformed"
}