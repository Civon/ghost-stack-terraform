# Create the resource group
resource "azurerm_resource_group" "rg" {
  location = var.resource_group_location
  name     = "${var.app_name}-rg"
}

# Create the Linux App Service Plan
resource "azurerm_service_plan" "appserviceplan" {
  name                = "${var.app_name}-webapp-asp"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  os_type             = "Linux"
  sku_name            = var.sku_name
  # reserved            = true # Mandatory for Linux plans
}

# Create the web app, pass in the App Service Plan ID
resource "azurerm_linux_web_app" "webapp" {
  name                = "${var.app_name}-webapp"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  service_plan_id     = azurerm_service_plan.appserviceplan.id
  # https_only            = true
  site_config {
    always_on = false # must be explicitly set to false when using Free, F1, D1, or Shared Service Plans.
    application_stack {
      docker_image     = "ghost"
      docker_image_tag = "5-alpine"
    }

  }

  app_settings = {
    # Do not attach Storage by default?
    WEBSITES_ENABLE_APP_SERVICE_STORAGE = var.websites_enable_app_service_storage

    # /*
    # Settings for private Container Registires  
    DOCKER_REGISTRY_SERVER_URL      = var.docker_registry_url
    DOCKER_REGISTRY_SERVER_USERNAME = var.docker_registry_username
    DOCKER_REGISTRY_SERVER_PASSWORD = var.docker_registry_password
    # */

    # Downloaded Application Settings from "mlab-docker-test"
    database__connection__client   = "mysql"
    database__connection__port     = "3306"
    database__connection__host     = var.database_host
    database__connection__user     = var.database_user
    database__connection__password = var.database_password
    database__connection__database = var.database_name

    # url = var.url
    url = "https://${var.app_name}-webapp.azurewebsites.net"
  }
  # storage_account {

  # }

  # application_logs {
  #   file_system_level = "Warning"
  # }
}
