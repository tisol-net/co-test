resource aws_s3_bucket weather_landing_bucket {
  bucket        = "weather-ingest"
  acl           = "private"

  lifecycle_rule {
    id      = "Service-Lifecycle"
    enabled = true
    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }
    transition {
      days          = 60
      storage_class = "GLACIER"
    }
    expiration {
      days = 180
    }
    noncurrent_version_transition {
      days          = 30
      storage_class = "GLACIER"
    }
    noncurrent_version_expiration {
      days = 90
    }
  }

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource aws_s3_bucket weather_transformed_bucket {
  bucket        = "weather-output"
  acl           = "private"

  lifecycle_rule {
    id      = "Service-Lifecycle"
    enabled = true
    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }
    transition {
      days          = 60
      storage_class = "GLACIER"
    }
    expiration {
      days = 180
    }
    noncurrent_version_transition {
      days          = 30
      storage_class = "GLACIER"
    }
    noncurrent_version_expiration {
      days = 90
    }
  }

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_s3_bucket_notification" "lambda_trigger" {
  bucket = aws_s3_bucket.weather_landing_bucket.id
  lambda_function {
    lambda_function_arn = var.trigger_function_arn
    events              = ["s3:ObjectCreated:*", "s3:ObjectRemoved:*"]

  }
}