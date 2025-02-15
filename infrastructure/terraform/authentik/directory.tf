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

resource "authentik_group" "grafana_admin" {
  name         = "Grafana Admins"
  is_superuser = false
}

resource "authentik_group" "default" {
  for_each     = local.authentik_groups
  name         = each.value.name
  is_superuser = false
}

resource "authentik_policy_binding" "application_policy_binding" {
  for_each = local.applications

  target = authentik_application.application[each.key].uuid
  group  = authentik_group.default[each.value.group].id
  order  = 0
}

module "onepassword_lldap" {
  source = "github.com/joryirving/terraform-1password-item"
  vault  = "secrets-automation"
  item   = "lldap"
}

resource "authentik_source_ldap" "lldap" {
  name      = "lldap"
  slug      = "lldap"
  start_tls = false

  server_uri    = module.onepassword_lldap.fields["LLDAP_AK_SERVER_URI"]
  bind_cn       = module.onepassword_lldap.fields["LLDAP_AK_BIND_CN"]
  bind_password = module.onepassword_lldap.fields["LLDAP_USER_ADMIN_PASS"]
  base_dn       = module.onepassword_lldap.fields["LLDAP_AK_BASE_DN"]

  property_mappings = [
    "1a6d6daf-b3f2-420b-b422-6d1b5cd1e278",
    "448bf5d7-2e43-47d2-a5a4-9663fa185760",
    "d1734f42-0f1a-4385-9fa6-44c5f51c86f3",
    "c102e661-ac40-4c89-b93c-552de1c5b3d9",
    "087d519b-89a1-42a0-9117-584313b68efb",
    "63348598-ec6f-4d04-8587-73dcfa23db7f"
  ]
  property_mappings_group = [
    "087d519b-89a1-42a0-9117-584313b68efb"
  ]

  user_path_template      = "LDAP/users"
  additional_user_dn      = "ou=people"
  additional_group_dn     = "ou=groups"
  user_object_filter      = "(objectClass=person)"
  group_object_filter     = "(objectClass=groupOfUniqueNames)"
  group_membership_field  = "member"
  object_uniqueness_field = "uid"

}
