SUBSCRIPTION_ID_MAIN = "xxxxxx"
zone                 = "dv"
env                  = "dev"
location             = "francecentral"
location_code        = "frc"
code_appli_socle     = "yy5"

databricks_workspace_id = "databricks_workspace_resource_id"

action_groups = [
  "action_group_resource_id_1",
  "action_group_resource_id_2",
]

severity                = 3
window_duration         = "P2D"
evaluation_frequency    = "PT15M"
auto_mitigation_enabled = true

# test update di
tags = {
  code_appli  = "yy5"
  commentaire = "Pltf Data - environnement de developpement"
  created_by  = "terraform - SPN-DEV"
  environment = "Developpement"
  contact     = "hello@example.com"
}

