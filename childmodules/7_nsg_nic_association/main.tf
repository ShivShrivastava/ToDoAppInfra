resource "azurerm_network_interface_security_group_association" "nsgnicassociation" {
  network_interface_id      = var.nic_id1
  network_security_group_id = var.nsg_id
}