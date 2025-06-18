terraform {
  required_providers {
    authentik = {
      source  = "goauthentik/authentik"
      version = "2025.6.0"
    }

    onepassword = {
      source  = "1Password/onepassword"
      version = "2.1.2"
    }
  }
}

provider "onepassword" {
  url                   = var.service_account_json != null ? "http://onepassword.security.svc.cluster.local" : null
  token                 = var.service_account_json
  service_account_token = var.onepassword_sa_token
}

module "onepassword_authentik" {
  source = "github.com/joryirving/terraform-1password-item"
  vault  = "secrets-automation"
  item   = "authentik"
}

provider "authentik" {
  url   = "https://sso.${var.cluster_domain}"
  token = module.onepassword_authentik.fields["AK_TOKEN"]
}
