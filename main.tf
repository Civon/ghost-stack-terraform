# Create the resource group
resource "azurerm_resource_group" "rg" {
  location = var.resource_group_location
  name     = "${var.app_name}-rg"
}

module "web_app_container" {
  source = "innovationnorway/web-app-container/azurerm"

  name                = "${var.app_name}-webapp"
  resource_group_name = azurerm_resource_group.rg.name
  port                = 8080
  always_on           = var.always_on

  docker_registry_url      = var.docker_registry_url
  docker_registry_username = var.docker_registry_username
  docker_registry_password = var.docker_registry_password

  container_type   = "compose"
  container_config = <<EOF
# by default, the Ghost image will use SQLite (and thus requires no separate database container)
# we have used MySQL here merely for demonstration purposes (especially environment-variable-based configuration)

version: "3.1"

services:
  ghost:
    image: ghost:5-alpine
    restart: always
    ports:
      - 8080:2368
    environment:
      # see https://ghost.org/docs/config/#configuration-options
      database__client: mysql
      database__connection__host: $${DATABASE_HOST}
      database__connection__user: $${DATABASE_USER}
      database__connection__password: $${DATABASE_PASSWORD}
      # database__connection__password: example
      database__connection__database: $${DATABASE_NAME}
      # this url value is just an example, and is likely wrong for your environment!
      url: $${URL}
      # contrary to the default mentioned in the linked documentation, this image defaults to NODE_ENV=production (so development mode needs to be explicitly specified if desired)
      #NODE_ENV: development
    volumes:
      # - /home/site/content:/var/lib/ghost/content
      - $${WEBAPP_STORAGE_HOME}/content:/var/lib/ghost/content/
      - ghostimagesss:/var/lib/ghost/content/images/

    # network_mode: "host"

EOF
}
resource "azurerm_app_service" "main" {
sku_name = var.sku_name
}