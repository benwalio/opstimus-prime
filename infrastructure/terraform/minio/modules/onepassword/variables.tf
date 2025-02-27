variable "onepassword_vault" {
  type        = string
  description = "Name of the 1password vault"
}

variable "item_title" {
  type        = string
  description = "Name of the 1password item (name-tfm-minio)"
}

variable "item_username" {
  type        = string
  description = "Username"
}

variable "item_password" {
  type        = string
  description = "Password"
  sensitive   = true
}

variable "item_minio_access_key" {
  type        = string
  description = "Minio_access_key"
}

variable "item_minio_secret_key" {
  type        = string
  description = "Minio_secret_key"
  sensitive   = true
}

variable "item_minio_bucket" {
  type        = string
  description = "Minio_bucket"
}
