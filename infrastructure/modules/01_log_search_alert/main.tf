resource "azurerm_monitor_scheduled_query_rules_alert_v2" "this" {
  name                = "al-${var.location_code}-${var.zone}-${var.code_appli_socle}_${var.code_appli}_${var.consigne}_jobFail"
  resource_group_name = "rg-${var.location_code}-${var.zone}-${var.code_appli_socle}-ptf-data"
  location            = var.location

  scopes               = [var.databricks_workspace_id]
  window_duration      = var.window_duration
  evaluation_frequency = var.evaluation_frequency
  severity             = var.severity

  criteria {
    query                   = <<QUERY
let jobIds = dynamic([${join(",", formatlist("'%s'", var.job_ids))}]);
DatabricksJobs
| where ActionName in ('runFailed', 'runSucceeded')
| extend JobId = tostring(parse_json(RequestParams).jobId)
| where JobId in (jobIds)
| summarize arg_max(TimeGenerated, *) by JobId
| where ActionName == 'runFailed'
QUERY
    time_aggregation_method = "Count"
    operator                = "GreaterThan"
    threshold               = 0

    dimension {
      name     = "JobId"
      operator = "Include"
      values   = ["*"]
    }
  }

  action {
    action_groups = var.action_groups
    custom_properties = {
      trigramme_project = var.code_appli
      consigne          = var.consigne
      priority          = var.env == "pr" ? "SENSIBLE" : "INITIAL"
      ticket_impact     = var.env == "pr" ? "FORT" : "LIMITE"
      agent_assign      = var.env == "pr" ? "XXX" : "YYYY"
      ticket_priority   = "INITIAL"
    }
  }

  auto_mitigation_enabled = var.auto_mitigation_enabled

  tags = merge(
    var.tags,
    {
      trigramme_project = var.code_appli
      consigne          = var.consigne
    }
  )
}