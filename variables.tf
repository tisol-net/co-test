accounts = {
  live    = "178668284513"
  asur    = "910873820060"
  test    = "644536951056"
  staging = "539477383635"
}

variable accounts {
  description = "Account IDs for environment accounts"
  type = object(
    {
      live    = string
      asur    = string
      test    = string
      staging = string
    }
  )
}