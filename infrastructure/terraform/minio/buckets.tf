locals {
  buckets = [
    "dragonfly",
    "postgres",
    "postgres16",
    "volsync"
  ]
}

module "minio" {
  source           = "./modules/minio"
  bucket_name      = "dragonfly"
  onepassword_item = "dragonfly"
  onepassword_slug = "DF"
  user_name        = random_password.user_name["dragonfly"].result
  user_secret      = random_password.user_secret["dragonfly"].result

  providers = {
    minio       = minio
    onepassword = onepassword
  }
}

module "minio" {
  source           = "./modules/minio"
  bucket_name      = "postgres"
  onepassword_item = "postgres"
  onepassword_slug = "PG"
  user_name        = random_password.user_name["postgres"].result
  user_secret      = random_password.user_secret["postgres"].result

  providers = {
    minio       = minio
    onepassword = onepassword
  }
}

module "minio" {
  source           = "./modules/minio"
  bucket_name      = "postgres16"
  onepassword_item = "postgres"
  onepassword_slug = "PG16"
  user_name        = random_password.user_name["postgres16"].result
  user_secret      = random_password.user_secret["postgres16"].result

  providers = {
    minio       = minio
    onepassword = onepassword
  }
}

module "minio" {
  source           = "./modules/minio"
  bucket_name      = "volsync"
  onepassword_item = "volsync"
  onepassword_slug = "VSYNC"
  user_name        = random_password.user_name["volsync"].result
  user_secret      = random_password.user_secret["volsync"].result

  providers = {
    minio       = minio
    onepassword = onepassword
  }
}

# module "onepassword_dragonfly" {
#   source = "github.com/joryirving/terraform-1password-item"
#   vault  = data.onepassword_vault.kubernetes.name
#   item   = "dragonfly"
# }

# resource "minio_s3_bucket" "dragonfly" {
#   bucket = "dragonfly"
#   acl    = "private"
# }

# resource "minio_iam_user" "dragonfly" {
#   name   = module.onepassword_dragonfly.fields["DF_MINIO_ACCESS_KEY"]
#   secret = module.onepassword_dragonfly.fields["DF_MINIO_SECRET_KEY"]
# }

# resource "minio_iam_policy" "dragonfly" {
#   name   = "dragonfly-policy"
#   policy = <<EOF
# {
#     "Version": "2012-10-17",
#     "Statement": [
#         {
#             "Effect": "Allow",
#             "Action": [
#                 "s3:*"
#             ],
#             "Resource": [
#                 "arn:aws:s3:::dragonfly",
#                 "arn:aws:s3:::dragonfly/*"
#             ],
#             "Sid": ""
#         }
#     ]
# }
# EOF
# }

# resource "minio_iam_user_policy_attachment" "dragonfly" {
#   user_name   = minio_iam_user.dragonfly.id
#   policy_name = minio_iam_policy.dragonfly.id
# }

# module "onepassword_cnpg" {
#   source = "github.com/joryirving/terraform-1password-item"
#   vault  = data.onepassword_vault.kubernetes.name
#   item   = "cloudnative-pg"
# }

# resource "minio_s3_bucket" "postgres" {
#   bucket = "postgres"
#   acl    = "private"
# }

# resource "minio_s3_bucket" "postgres16" {
#   bucket = "postgres16"
#   acl    = "private"
# }

# resource "minio_iam_user" "cnpg" {
#   name   = module.onepassword_cnpg.fields["CNPG_MINIO_ACCESS_KEY"]
#   secret = module.onepassword_cnpg.fields["CNPG_MINIO_SECRET_KEY"]
# }

# resource "minio_iam_policy" "cnpg" {
#   name   = "cnpg-policy"
#   policy = <<EOF
# {
#     "Version": "2012-10-17",
#     "Statement": [
#         {
#             "Effect": "Allow",
#             "Action": [
#                 "s3:*"
#             ],
#             "Resource": [
#                 "arn:aws:s3:::postgres",
#                 "arn:aws:s3:::postgres/*",
#                 "arn:aws:s3:::postgres16",
#                 "arn:aws:s3:::postgres16/*"
#             ],
#             "Sid": ""
#         }
#     ]
# }
# EOF
# }

# resource "minio_iam_user_policy_attachment" "cnpg" {
#   user_name   = minio_iam_user.cnpg.id
#   policy_name = minio_iam_policy.cnpg.id
# }

# module "onepassword_volsync" {
#   source = "github.com/joryirving/terraform-1password-item"
#   vault  = data.onepassword_vault.kubernetes.name
#   item   = "volsync-template"
# }

# resource "minio_s3_bucket" "volsync" {
#   bucket = "volsync"
#   acl    = "private"
# }

# resource "minio_iam_user" "volsync" {
#   name   = module.onepassword_volsync.fields["VS_MINIO_ACCESS_KEY"]
#   secret = module.onepassword_volsync.fields["VS_MINIO_SECRET_KEY"]
# }

# resource "minio_iam_policy" "volsync" {
#   name   = "volsync-policy"
#   policy = <<EOF
# {
#     "Version": "2012-10-17",
#     "Statement": [
#         {
#             "Effect": "Allow",
#             "Action": [
#                 "s3:*"
#             ],
#             "Resource": [
#                 "arn:aws:s3:::volsync",
#                 "arn:aws:s3:::volsync/*"
#             ],
#             "Sid": ""
#         }
#     ]
# }
# EOF
# }

# resource "minio_iam_user_policy_attachment" "volsync" {
#   user_name   = minio_iam_user.volsync.id
#   policy_name = minio_iam_policy.volsync.id
# }


# module "minio" {
#   source      = "./modules/minio"
#   bucket_name = "dragonfly"
#   user_name   = random_password.user_name[each.key].result
#   user_secret = random_password.user_secret[each.key].result

#   providers = {
#     minio = minio
#   }
# }
