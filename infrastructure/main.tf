data "local_file" "jobs_json" {
  filename = "${path.module}/environments/jobs_par_code_appli.json"
}

locals {
  jobs_data = jsondecode(data.local_file.jobs_json.content)
}

module "log_search_alerts" {
  source = "./modules/01_log_search_alert"

  for_each = {
    for entry in flatten([
      for code_appli, consignes in local.jobs_data : [
        for consigne, job_ids in consignes : {
          key        = "${code_appli}-${consigne}"
          code_appli = code_appli
          consigne   = consigne
          job_ids    = job_ids
        }
      ]
    ]) : entry.key => entry
    if entry.consigne != "null"
  }

  location_code           = var.location_code
  zone                    = var.zone
  env                     = var.env
  code_appli              = each.value.code_appli
  code_appli_socle        = var.code_appli_socle
  consigne                = each.value.consigne
  job_ids                 = each.value.job_ids
  location                = var.location
  databricks_workspace_id = var.databricks_workspace_id
  action_groups           = var.action_groups
  tags                    = var.tags
  severity                = var.severity
  window_duration         = var.window_duration
  evaluation_frequency    = var.evaluation_frequency
  auto_mitigation_enabled = var.auto_mitigation_enabled
}