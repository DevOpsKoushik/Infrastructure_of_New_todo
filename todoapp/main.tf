

module "resource_group" {
  source                  = "../modules/azurerm_resource_group"
  resource_group_name     = "knrgtodoapp"
  resource_group_location = "Japan East"
}

module "public_ip" {
  depends_on          = [module.resource_group]
  source              = "../modules/azurerm_public_ip"
  public_ip_name      = "knpip"
  location            = "Japan East"
  resource_group_name = "knrgtodoapp"
  allocation_method   = "Static"
}


module "virtual_network" {
  depends_on               = [module.resource_group]
  source                   = "../modules/azurerm_virtual_network"
  virtual_network_name     = "vnettodoapp"
  virtual_network_location = "Japan East"
  resource_group_name      = "knrgtodoapp"
  address_space            = ["10.0.0.0/16"]
}

module "subnet" {
  depends_on           = [module.virtual_network]
  source               = "../modules/azurerm_subnet"
  resource_group_name  = "knrgtodoapp"
  virtual_network_name = "vnettodoapp"
  subnet_name          = "knsubnet"
  address_prefixes     = ["10.0.1.0/24"]
}




module "virtual_machine" {
  depends_on          = [module.subnet]
  source              = "../modules/azurerm_virtual_machine"
  nic_name            = "frontend_nic"
  nic_location        = "Japan East"
  resource_group_name = "knrgtodoapp"
  subnet_name         = "knsubnet"
  vnet_name           = "vnettodoapp"
  vm_name             = "koushikvm"
  location            = "Japan East"
  vm_size             = "Standard_D4as_v6"
  image_publisher     = "Canonical"
  image_offer         = "0001-com-ubuntu-server-jammy"
  image_sku           = "22_04-lts-gen2"
  image_version       = "latest"
  public_ip_name      = "knpip"
}


module "network_security_group" {
  depends_on   = [module.virtual_machine]
  source       = "../modules/azurerm_nsg"
  nsg_name     = "frontend_nsg"
  nsg_location = "Japan East"
  rg_name      = "knrgtodoapp"
}






