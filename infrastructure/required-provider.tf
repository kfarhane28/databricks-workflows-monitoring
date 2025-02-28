terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.0"
    }
  }
  backend "http" {
    #address = "https://gitlab.serv.cdc.fr/api/v4/projects/389/terraform/state/di-1"
  } # Configurer le backend distant si nécessaire
}