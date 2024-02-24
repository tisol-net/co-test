variable accounts {
  description = "Account IDs for environment accounts"
  type = object(
    {
      dev = string
    }
  )
}

variable region {
  type    = string
  default = "eu-west-2"
}