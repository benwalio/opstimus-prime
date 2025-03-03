locals {
  buckets = [
    "dragonfly",
    "crunchy-pgo",
    "crunchy-pgo-vector",
    "nextcloud",
    "nocodb",
    "n8n",
    "postgres",
    "postgres16",
    "public",
    "volsync"
  ]
}

# tofu import 'module.onepassword["dragonfly"].onepassword_item.item' vaults/$$vaultid/items/crunchy-pgo-vector-tfm-minio


# import {
#   for_each = toset(local.buckets)
#   to       = module.minio[each.key].minio_s3_bucket.bucket
#   id       = each.key
# }

# import {
#   for_each = toset(local.buckets)
#   to       = module.minio[each.key].minio_iam_policy.policy
#   id       = "${each.key}-policy"
# }

# import {
#   for_each = toset(local.buckets)
#   to       = module.minio[each.key].minio_iam_service_account.service_account
#   id       = each.key
# }

# import {
#   for_each = toset(local.buckets)
#   to       = module.minio[each.key].minio_iam_user.user
#   id       = each.key
# }

# import {
#   for_each = toset(local.buckets)
#   to       = module.minio[each.key].minio_iam_user_policy_attachment.attachment
#   id       = "${each.key}/${each.key}-policy"
# }

module "minio" {
  for_each = toset(local.buckets)
  source   = "./modules/minio"

  bucket_name = each.key

  user_name   = each.key
  user_secret = random_password.user_secret[each.key].result

  providers = {
    minio = minio
  }
}

module "onepassword" {
  for_each          = module.minio
  source            = "./modules/onepassword"
  onepassword_vault = data.onepassword_vault.kubernetes.uuid

  item_title        = "${each.value.bucket}-tfm-minio"
  item_minio_bucket = each.value.bucket

  item_username = each.value.username
  item_password = each.value.password

  item_minio_access_key = each.value.access_key
  item_minio_secret_key = each.value.secret_key


  providers = {
    onepassword = onepassword
  }

}
