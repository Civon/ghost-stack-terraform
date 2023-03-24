variable "resource_group_location" {
  default     = "eastus" # availble options: uk europe ukwest eastus2
  description = "Location of the resource group."
}

variable "app_name" {
  default     = "nexpresso-dev"
  description = "Dev resource group"
}

variable "sku_name" {
  default     = "F1"
  description = "SKU size of webapp"
}
variable "always_on" {
  default     = false
  description = "For F1 plan, always_on must be false"
}
variable "docker_registry_url" {
  type      = string
  sensitive = true
}
variable "docker_registry_username" {
  type      = string
  sensitive = true
}
variable "docker_registry_password" {
  type      = string
  sensitive = true
}

variable "database_host" {
  type      = string
  sensitive = true
}
variable "database_name" {
  description = "The name of the database"
  type        = string
}

variable "database_password" {
  description = "The password for the database user"
  type        = string
  sensitive   = true
}

variable "database_user" {
  description = "The username for the database user"
  type        = string
  sensitive   = true
}

variable "docker_registry_server_url" {
  description = "The URL for the Docker registry server"
  type        = string
  default     = "https://index.docker.io/v1"
  sensitive   = true
}

# TODO: can use var here. ad-hoc use default in webapp.app_settings
# variable "url" {
#   description = "The URL of the website"
#   type        = string
#   default     = "https://${local.app_name}-webapp.azurewebsites.net"
# }

variable "websites_enable_app_service_storage" {
  description = "Whether to enable storage for the website"
  type        = bool
  default     = false
}


# variable "storage_account_access_key" {
#   description = "The access key for the Azure Storage account."
#   sensitive   = true
# }

# variable "storage_account_name" {
#   description = "The name of the Azure Storage account."
# }

# variable "storage_file_share_name" {
#   description = "The name of the file share to mount."
# }


locals {
  # url = "https://${var.app_name}-webapp.azurewebsites.net"
  # app_name = "nexpresso-dev"
}
