terraform {
  required_providers {
    minio = {
      source  = "aminueza/minio"
      version = "3.2.4"
    }

    onepassword = {
      source  = "1Password/onepassword"
      version = "2.1.2"
    }
  }
}

resource "minio_s3_bucket" "bucket" {
  bucket = var.bucket_name
  acl    = "private"
}

resource "minio_iam_user" "user" {
  name   = var.user_name
  secret = var.user_secret
}

resource "minio_iam_policy" "policy" {
  name   = "${var.bucket_name}-policy"
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:*"
            ],
            "Resource": [
                "arn:aws:s3:::${minio_s3_bucket.bucket.bucket}",
                "arn:aws:s3:::${minio_s3_bucket.bucket.bucket}/*"
            ],
            "Sid": ""
        }
    ]
}
EOF
}

resource "minio_iam_user_policy_attachment" "attachment" {
  user_name   = minio_iam_user.user.id
  policy_name = minio_iam_policy.policy.id
}

resource "minio_iam_service_account" "service_account" {
  target_user = minio_iam_user.user.name
  description = minio_iam_user.user.name
}

resource "onepassword_item" "item" {
  vault    = var.onepassword_vault
  title    = "${var.onepassword_item}-tfm-minio"
  category = "login"

  username = var.user_name
  password = var.user_secret

  url  = "https://s3.benwal.rodeo"
  tags = ["automation/terraform"]

  section {
    label = "MINIO"
    field {
      label = "MINIO_UI_USER"
      type  = "STRING"
      value = var.user_name
    }

    field {
      label = "MINIO_UI_PASS"
      type  = "CONCEALED"
      value = var.user_secret
    }

    field {
      label = "MINIO_ACCESS_KEY"
      type  = "STRING"
      value = minio_iam_service_account.service_account.access_key
    }
    field {
      label = "MINIO_SECRET_KEY"
      type  = "CONCEALED"
      value = minio_iam_service_account.service_account.secret_key
    }
  }
}
