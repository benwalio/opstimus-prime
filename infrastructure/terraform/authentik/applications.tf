locals {
  oauth_apps = [
    "cloudflare",
    "grafana",
    "headlamp",
    "hoarder",
    "immich",
    "lubelog",
    "nextcloud",
    "paperless",
    "vikunja",
  ]
}

module "onepassword_application" {
  for_each = toset(local.oauth_apps)
  source   = "github.com/joryirving/terraform-1password-item"
  vault    = "secrets-automation"
  item     = each.key
}

locals {
  applications = {
    cloudflare-access = {
      client_id     = module.onepassword_application["cloudflare"].fields["CFZT_AK_CLIENT_ID"]
      client_secret = module.onepassword_application["cloudflare"].fields["CFZT_AK_CLIENT_SECRET"]
      group         = "infrastructure"
      icon_url      = "https://raw.githubusercontent.com/homarr-labs/dashboard-icons/main/svg/cloudflare-zero-trust.svg"
      redirect_uris = ["https://benwal.cloudflareaccess.com/cdn-cgi/access/callback"]
      launch_url    = "https://benwal.cloudflareaccess.com/#/Launcher"
    },
    grafana = {
      client_id     = module.onepassword_application["grafana"].fields["GF_AK_CLIENT_ID"]
      client_secret = module.onepassword_application["grafana"].fields["GF_AK_CLIENT_SECRET"]
      group         = "monitoring"
      icon_url      = "https://raw.githubusercontent.com/homarr-labs/dashboard-icons/main/png/grafana.png"
      redirect_uris = ["https://grafana.${var.cluster_domain}/login/generic_oauth"]
      launch_url    = "https://grafana.${var.cluster_domain}/login/generic_oauth"
    },
    headlamp = {
      client_id     = module.onepassword_application["headlamp"].fields["HL_AK_CLIENT_ID"]
      client_secret = module.onepassword_application["headlamp"].fields["HL_AK_CLIENT_SECRET"]
      group         = "infrastructure"
      icon_url      = "https://raw.githubusercontent.com/headlamp-k8s/headlamp/refs/heads/main/frontend/src/resources/icon-dark.svg"
      redirect_uris = ["https://headlamp.${var.cluster_domain}/oidc-callback"]
      launch_url    = "https://headlamp.${var.cluster_domain}/"
    },
    hoarder = {
      client_id     = module.onepassword_application["hoarder"].fields["HDR_AK_CLIENT_ID"]
      client_secret = module.onepassword_application["hoarder"].fields["HDR_AK_CLIENT_SECRET"]
      group         = "monitoring"
      icon_url      = "https://raw.githubusercontent.com/homarr-labs/dashboard-icons/main/png/hoarder.png"
      redirect_uris = ["https://hoarder.${var.cluster_domain}/api/auth/callback/custom"]
      launch_url    = "https://hoarder.${var.cluster_domain}/api/auth/callback/custom"
    },
    immich = {
      client_id     = module.onepassword_application["immich"].fields["IMMICH_AK_CLIENT_ID"]
      client_secret = module.onepassword_application["immich"].fields["IMMICH_AK_CLIENT_SECRET"]
      group         = "home"
      icon_url      = "https://raw.githubusercontent.com/homarr-labs/dashboard-icons/main/png/immich.png"
      redirect_uris = ["https://photos.${var.cluster_domain}/auth/login", "https://photos.${var.cluster_domain}/user-settings", "app.immich:///oauth-callback"]
      launch_url    = "https://photos.${var.cluster_domain}/auth/login"
    },
    lubelog = {
      client_id     = module.onepassword_application["lubelog"].fields["LUBEL_AK_CLIENT_ID"]
      client_secret = module.onepassword_application["lubelog"].fields["LUBEL_AK_CLIENT_SECRET"]
      group         = "home"
      icon_url      = "https://demo.lubelogger.com/defaults/lubelogger_icon_72.png"
      redirect_uris = ["https://lubelog.${var.cluster_domain}/Login/RemoteAuth"]
      launch_url    = "https://lubelog.${var.cluster_domain}/Login/RemoteAuth"
    },
    nextcloud = {
      client_id     = module.onepassword_application["nextcloud"].fields["NXC_AK_CLIENT_ID"]
      client_secret = module.onepassword_application["nextcloud"].fields["NXC_AK_CLIENT_SECRET"]
      group         = "monitoring"
      icon_url      = "https://raw.githubusercontent.com/homarr-labs/dashboard-icons/main/png/nextcloud.png"
      redirect_uris = ["https://nextcloud.${var.cluster_domain}/login"]
      launch_url    = "https://nextcloud.${var.cluster_domain}/login"
    },
    paperless = {
      client_id     = module.onepassword_application["paperless"].fields["PPRL_AK_CLIENT_ID"]
      client_secret = module.onepassword_application["paperless"].fields["PPRL_AK_CLIENT_SECRET"]
      group         = "home"
      icon_url      = "https://raw.githubusercontent.com/homarr-labs/dashboard-icons/main/png/paperless.png"
      redirect_uris = ["https://docs.${var.cluster_domain}/accounts/oidc/authentik/login/callback/"]
      launch_url    = "https://docs.${var.cluster_domain}/"
    },
    vikunja = {
      client_id     = module.onepassword_application["vikunja"].fields["VIKUNJA_AK_CLIENT_ID"]
      client_secret = module.onepassword_application["vikunja"].fields["VIKUNJA_AK_CLIENT_SECRET"]
      group         = "home"
      icon_url      = "https://raw.githubusercontent.com/homarr-labs/dashboard-icons/main/png/vikunja.png"
      redirect_uris = ["https://vikunja.${var.cluster_domain}/auth/openid/authentik"]
      launch_url    = "https://vikunja.${var.cluster_domain}/"
    },
  }
}

resource "authentik_provider_oauth2" "oauth2" {
  for_each              = local.applications
  name                  = each.key
  client_id             = each.value.client_id
  client_secret         = each.value.client_secret
  authorization_flow    = authentik_flow.provider-authorization-implicit-consent.uuid
  authentication_flow   = authentik_flow.authentication.uuid
  invalidation_flow     = data.authentik_flow.default-provider-invalidation-flow.id
  property_mappings     = data.authentik_property_mapping_provider_scope.oauth2.ids
  access_token_validity = "hours=4"
  signing_key           = data.authentik_certificate_key_pair.generated.id

  allowed_redirect_uris = toset(
    [for uri in each.value.redirect_uris :
      {
        matching_mode = "strict",
        url           = uri
      }
    ]
  )
}

resource "authentik_application" "application" {
  for_each           = local.applications
  name               = title(each.key)
  slug               = each.key
  protocol_provider  = authentik_provider_oauth2.oauth2[each.key].id
  group              = authentik_group.default[each.value.group].name
  open_in_new_tab    = true
  meta_icon          = each.value.icon_url
  meta_launch_url    = each.value.launch_url
  policy_engine_mode = "any"
}
