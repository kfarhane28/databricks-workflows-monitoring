variable "SUBSCRIPTION_ID_MAIN" {
  type        = string
  description = "The Subscription ID for main deployment "
}

variable "location_code" {
  description = "The location code for the resource."
  type        = string
}

variable "zone" {
  description = "The zone for the resource."
  type        = string
}

variable "env" {
  description = "The environment for the resource."
  type        = string
}

variable "code_appli_socle" {
  type        = string
  description = "Code de l'application socle"
}

variable "databricks_workspace_id" {
  description = "The ID of the Databricks workspace."
  type        = string
}

variable "location" {
  description = "The location of the resource."
  type        = string
}

variable "jobs_data" {
  description = "A map of job data"
  type        = map(map(list(string)))
  default     = {}
}

variable "jobs_data_file" {
  description = "Chemin du fichier JSON contenant les données des jobs"
  type        = string
  default     = "jobs_par_code_appli.json"
}

/*
variable "job_ids" {
  type        = list(string)
  description = "Liste des IDs des jobs Databricks à surveiller"
}
*/

variable "action_groups" {
  type        = list(string)
  description = "Liste des groupes d'action à déclencher"
}

variable "tags" {
  type        = map(any)
  description = "tags list"
}

variable "severity" {
  description = "The severity level of the alert."
  type        = number
}

variable "window_duration" {
  description = "The window duration for the alert."
  type        = string
}

variable "evaluation_frequency" {
  description = "The evaluation frequency for the alert."
  type        = string
}

variable "auto_mitigation_enabled" {
  description = "Whether auto mitigation is enabled for the alert."
  type        = bool
}