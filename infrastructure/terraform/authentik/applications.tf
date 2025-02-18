locals {
  oauth_apps = [
    "grafana"
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
    grafana = {
      client_id     = module.onepassword_application["grafana"].fields["GF_AK_CLIENT_ID"]
      client_secret = module.onepassword_application["grafana"].fields["GF_AK_CLIENT_SECRET"]
      group         = "monitoring"
      icon_url      = "https://raw.githubusercontent.com/homarr-labs/dashboard-icons/main/png/grafana.png"
      redirect_uri  = "https://grafana.${var.cluster_domain}/login/generic_oauth"
      launch_url    = "https://grafana.${var.cluster_domain}/login/generic_oauth"
    }
  }
}

data "authentik_group" "appusers" {
  name = "authentik appusers"
}

data "authentik_group" "superusers" {
  name = "authentik superusers"
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
  allowed_redirect_uris = [
    {
      matching_mode = "strict",
      url           = each.value.redirect_uri,
    }
  ]
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
  policy_engine_mode = "all"
}
