locals {
  buckets = [
    "dragonfly",
    "nocodb",
    "n8n",
    "postgres",
    "postgres16",
    "volsync"
  ]
}

module "minio" {
  for_each          = toset(local.buckets)
  source            = "./modules/minio"
  onepassword_vault = data.onepassword_vault.kubernetes.uuid

  bucket_name = each.key

  user_name   = each.key
  user_secret = random_password.user_secret[each.key].result

  onepassword_item = each.key

  providers = {
    minio       = minio
    onepassword = onepassword
  }
}
