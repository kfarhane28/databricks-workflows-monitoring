SUBSCRIPTION_ID_MAIN = "xxxxxx"
env                  = "dev"
location             = "francecentral"

databricks_workspace_id = "databricks_workspace_resource_id"

action_groups = [
  "action_group_resource_id_1",
  "action_group_resource_id_2",
]

severity                = 3
window_duration         = "P2D"
evaluation_frequency    = "PT15M"
auto_mitigation_enabled = true #enable auto resolution of incident in Azure Monitor and in BMC TrueSight

