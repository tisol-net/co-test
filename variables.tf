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