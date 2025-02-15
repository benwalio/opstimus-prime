variable "bucket_name" {
  type = string
}

variable "user_name" {
  type      = string
  sensitive = true
}

variable "user_secret" {
  type      = string
  sensitive = true
}

variable "onepassword_vault" {
  type        = string
  description = "Name of the 1password vault"
  default     = "secrets-automation"
}

variable "onepassword_item" {
  type        = string
  description = "Name of the 1password item"
}

variable "onepassword_slug" {
  type        = string
  description = "Key slug (PG for postgres, eg)"
}
