locals {
  authentik_groups = {
    home           = { name = "home" }
    infrastructure = { name = "infrastructure" }
    media          = { name = "media" }
    monitoring     = { name = "monitoring" }
    users          = { name = "users" }
  }
}

data "authentik_group" "admins" {
  name = "authentik Admins"
}


resource "authentik_group" "default" {
  for_each     = local.authentik_groups
  name         = each.value.name
  is_superuser = false
}

resource "authentik_group" "appusers" {
  name = "authentik appusers"
}


resource "authentik_group" "grafana_admin" {
  name         = "grafana admins"
  is_superuser = false
}

resource "authentik_group" "superusers" {
  name         = "authentik superusers"
  is_superuser = true
  parent       = authentik_group.appusers.id
}


resource "authentik_policy_binding" "application_policy_binding" {
  for_each = local.applications

  target = authentik_application.application[each.key].uuid
  group  = authentik_group.default[each.value.group].id
  order  = 0
}

resource "authentik_policy_binding" "application_policy_binding_superusers" {
  for_each = local.applications

  target = authentik_application.application[each.key].uuid
  group  = authentik_group.superusers.id
  order  = 0
}

module "onepassword_lldap" {
  source = "github.com/joryirving/terraform-1password-item"
  vault  = "secrets-automation"
  item   = "lldap"
}

data "authentik_property_mapping_source_ldap" "lldap_user_mappings" {
  managed_list = [
    "goauthentik.io/sources/ldap/default-mail",
    "goauthentik.io/sources/ldap/default-name",
    "goauthentik.io/sources/ldap/ms-givenName",
    "goauthentik.io/sources/ldap/ms-sn",
    "goauthentik.io/sources/ldap/openldap-cn",
    "goauthentik.io/sources/ldap/openldap-uid"
  ]
}

data "authentik_property_mapping_source_ldap" "lldap_group_mappings" {
  managed_list = [
    "goauthentik.io/sources/ldap/openldap-cn"
  ]

}
resource "authentik_source_ldap" "lldap" {
  name      = "lldap"
  slug      = "lldap"
  start_tls = false

  server_uri    = module.onepassword_lldap.fields["LLDAP_AK_SERVER_URI"]
  bind_cn       = module.onepassword_lldap.fields["LLDAP_AK_BIND_CN"]
  bind_password = module.onepassword_lldap.fields["LLDAP_USER_ADMIN_PASS"]
  base_dn       = module.onepassword_lldap.fields["LLDAP_AK_BASE_DN"]

  password_login_update_internal_password = true

  property_mappings       = data.authentik_property_mapping_source_ldap.lldap_user_mappings.ids
  property_mappings_group = data.authentik_property_mapping_source_ldap.lldap_group_mappings.ids

  user_path_template      = "LDAP/users"
  additional_user_dn      = "ou=people"
  additional_group_dn     = "ou=groups"
  user_object_filter      = "(objectClass=person)"
  group_object_filter     = "(objectClass=groupOfUniqueNames)"
  group_membership_field  = "member"
  object_uniqueness_field = "uid"

}
