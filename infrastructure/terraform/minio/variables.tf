variable "onepassword_sa_token" {
  type        = string
  description = "OP Service Account Token"
  sensitive   = true
  default     = null
}

variable "service_account_json" {
  type        = string
  description = "The path to the service account JSON for OnePassword."
  sensitive   = true
  default     = null
}

variable "minio_url" {
  type        = string
  description = "Minio Server URL"
  default     = "s3.benwal.rodeo"
}


variable "minio_buckets" {
  description = "Map of buckets for minio"
  type        = map(any)

  default = {
    # dragonfly = {
    #   op_item = "dragonfly-tfm-minio"
    # }
    # postgres = {
    #   op_item = "cloudnative-pg-tfm-minio"
    # }
    postgres16 = {
      op_item = "cloudnative-pg16-tfm-minio"
    }
    volsync = {
      op_item = "volsync-tfm-minio"
    }
  }

}
