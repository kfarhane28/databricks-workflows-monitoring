output "log_search_alert_names" {
  value = {
    for k, v in module.log_search_alerts : k => v.alert_name
  }
}