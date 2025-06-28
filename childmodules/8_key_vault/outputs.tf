output "vm1_username" {
  value = data.azurerm_key_vault_secret.username.value
  sensitive = true
}

output "vm1_password" {
 value = data.azurerm_key_vault_secret.password.value
   sensitive = true
}

output "sqladmin_username" {
  value = data.azurerm_key_vault_secret.sqlusername.value
    sensitive = true
}

output "sqladmin_password" {
  value = data.azurerm_key_vault_secret.sqlpassword.value
    sensitive = true
}