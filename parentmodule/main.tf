module "rg" {
  source = "../childmodules/1_resource_group"
  
  rg_name     = var.rg_name
  rg_location = var.rg_location
}

module "vnet" {
  source = "../childmodules/2_virtual_network"
  depends_on    = [module.rg]

  vnet_name     = var.vnet_name
  address_space = var.address_space
  rg_name       = var.rg_name
  rg_location   = var.rg_location
}

module "subnet1" {
  source = "../childmodules/3_subnet"
  depends_on = [module.rg, module.vnet]

  subnet_name      = "frontendsubnet"
  address_prefixes = ["10.0.1.0/24"]
  vnet_name        = var.vnet_name
  rg_name          = var.rg_name
}

module "subnet2" {
  source = "../childmodules/3_subnet"
  depends_on = [module.rg, module.vnet]

  subnet_name      = "backsendsubnet"
  address_prefixes = ["10.0.2.0/24"]
  vnet_name        = var.vnet_name
  rg_name          = var.rg_name
}

module "pip" {
  source            = "../childmodules/4_public_ip"

  public_ip_name    = "frontendpip"
  rg_name           = var.rg_name
  rg_location       = var.rg_location
  allocation_method = "Static"
}

module "nsg" {
  source = "../childmodules/5_nsg"
  depends_on = [module.subnet1, module.subnet2]

  nsg_name          = var.nsg_name
  rg_name           = var.rg_name
  rg_location       = var.rg_location
  nsg_rule_name     = "AllowHTTP"
}

module "nic" {
  source = "../childmodules/6_nic"
  depends_on = [module.subnet1, module.pip, module.nsg]

  nic_name          = "nic-frontend"
  rg_name           = var.rg_name
  rg_location       = var.rg_location
  vnet_name         = var.vnet_name
  subnet_name       = "frontendsubnet"
  public_ip_name    = "frontendpip"
  nsg_name          = var.nsg_name
  subnet_id         = module.subnet1.subnet_id
  pip_id            = module.pip.pip_id 
}

module "nsgnicassociation" {
  source = "../childmodules/7_nsg_nic_association"
  depends_on = [module.nic, module.nsg]

  nic_id1           = module.nic.nic_id3
  nsg_id           = module.nsg.nsg_id
}

data "azurerm_client_config" "current" {}

module "kv" {
  source = "../childmodules/8_key_vault"
  depends_on = [module.rg]

  # kv_name                   = var.kv_name
  rg_name                   = var.rg_name
  rg_location               = var.rg_location
  tenant_id                 = data.azurerm_client_config.current.tenant_id
}


module "vm" {
  source     = "../childmodules/9_virtual_machine"
  depends_on = [module.nic, module.kv]

  rg_name         = var.rg_name
  rg_location     = var.rg_location
  vm_name         = var.vm_name
  vm_size         = var.vm_size
  image_publisher = var.image_publisher
  image_offer     = var.image_offer
  image_sku       = var.image_sku
  image_version   = var.image_version
  nic_id1          = [module.nic.nic_id3]
  secretusername  = module.kv.vm1_username
  secretpassword  = module.kv.vm1_password
}

module "sql_server" {
  source     = "../childmodules/10_sql_server"
  depends_on = [module.rg, module.kv]

  sql_server_name = var.sql_server_name
  rg_name         = var.rg_name
  rg_location     = var.rg_location
  admin_login1     = module.kv.sqladmin_username
  admin_password1  = module.kv.sqladmin_password
}

module "sql_database" {
  source     = "../childmodules/11_sql_database"
  depends_on = [module.sql_server]

  sql_db_name = var.sql_db_name
  rg_name           = var.rg_name
  sql_server_name   = var.sql_server_name
  sql_server_id     = module.sql_server.sql_server_id
}