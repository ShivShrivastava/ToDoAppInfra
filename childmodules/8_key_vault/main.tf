data "azurerm_key_vault" "kv" {
  name                = "safehosue"
  resource_group_name = var.rg_name
}

data "azurerm_key_vault_secret" "username" {
  name         = "vm1-username"   #shivadmin
  key_vault_id = data.azurerm_key_vault.kv.id
}

data "azurerm_key_vault_secret" "password" {
  name         = "vm1-password"  #P@ssw0rd1234!
  key_vault_id = data.azurerm_key_vault.kv.id
}

data "azurerm_key_vault_secret" "sqlusername" {
  name         = "sqladmin-username"  #sqladmin
  key_vault_id = data.azurerm_key_vault.kv.id
  
}

data "azurerm_key_vault_secret" "sqlpassword" {
  name         = "sqladmin-password"  #P@ssw0rd1234!
  key_vault_id = data.azurerm_key_vault.kv.id
}