terraform {
  required_providers {
    onepassword = {
      source  = "1Password/onepassword"
      version = "2.1.2"
    }
  }
}

data "onepassword_vault" "vault" {
  uuid = var.onepassword_vault
}

resource "onepassword_item" "item" {
  vault    = data.onepassword_vault.vault.uuid
  title    = var.item_title
  category = "login"

  username = var.item_username
  password = var.item_password

  tags = ["automation/terraform"]

  section {
    label = "MINIO"

    field {
      label = "MINIO_UI_USER"
      type  = "STRING"
      value = var.item_username
    }

    field {
      label = "MINIO_UI_PASS"
      type  = "CONCEALED"
      value = var.item_password
    }

    field {
      label = "MINIO_ACCESS_KEY"
      type  = "STRING"
      value = var.item_minio_access_key
    }
    field {
      label = "MINIO_SECRET_KEY"
      type  = "CONCEALED"
      value = var.item_minio_secret_key
    }

    field {
      label = "MINIO_BUCKET"
      type  = "STRING"
      value = var.item_minio_bucket
    }
  }
}
