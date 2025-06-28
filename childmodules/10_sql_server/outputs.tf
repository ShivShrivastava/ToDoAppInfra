output "sql_server_id" {
  value = azurerm_mssql_server.sql_server.id
  
}

output "admin_login" {
  value = azurerm_mssql_server.sql_server.administrator_login
  
}

output "admin_password" {
  value     = azurerm_mssql_server.sql_server.administrator_login_password
  sensitive = true
}