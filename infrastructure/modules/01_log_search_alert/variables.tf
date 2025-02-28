variable "location_code" {
  type        = string
  description = "Code de la région Azure"
}

variable "zone" {
  type        = string
  description = "Zone d’hébergement"
}

variable "env" {
  description = "The environment for the resource."
  type        = string
}

variable "code_appli" {
  type        = string
  description = "Code de l'application concernée"
}

variable "code_appli_socle" {
  type        = string
  description = "Code de l'application socle"
}

variable "consigne" {
  type        = string
  description = "Code de la consigne"
}

variable "location" {
  type        = string
  description = "Emplacement Azure de l'alerte"
}

variable "job_ids" {
  type        = list(string)
  description = "Liste des IDs des jobs Databricks à surveiller"
}

variable "action_groups" {
  type        = list(string)
  description = "Liste des groupes d'action à déclencher"
}

variable "jobs_data_file" {
  description = "Chemin du fichier JSON contenant les données des jobs"
  type        = string
  default     = "jobs_par_code_appli.json"
}

variable "tags" {
  type        = map(any)
  description = "tags list"
}

variable "databricks_workspace_id" {
  type        = string
  description = "The ID of the Databricks workspace."
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