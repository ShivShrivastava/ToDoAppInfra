resource "azurerm_mssql_database" "sql_database" {

  name = var.sql_db_name
  collation    = "SQL_Latin1_General_CP1_CI_AS"
  license_type = "LicenseIncluded"
  max_size_gb  = 2
  sku_name     = "S0"
  server_id    = var.sql_server_id
}

