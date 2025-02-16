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
}

variable "onepassword_item" {
  type        = string
  description = "Name of the 1password item (name-tfm-minio)"
}
