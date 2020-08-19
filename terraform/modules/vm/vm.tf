resource "azurerm_network_interface" "test" {
  name                = "${var.prefix}-netinterface"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group}"

  ip_configuration {
    name                          = "internal"
    subnet_id                     = "${var.subnet_id}"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          =  "${var.public_ip}"

  }
}

resource "azurerm_linux_virtual_machine" "test" {
  name                = "${var.prefix}-vm"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group}"
  size                = "Standard_B1s"
  admin_username      = "ivan-clare_ngong"
  network_interface_ids = ["${azurerm_network_interface.test.id}"]
  admin_ssh_key {
    username   = "ivan-clare_ngong"
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDWmgS584kqm1dezqaGOe67Qsm3qaiSvhYEecoBMwDv05pdEXSaKTtZn23znVyh6puwMvs1DN/NYDIToOaKq9ZGpPMPLa/Ss1gAgq0bcfl5kUdrLVDA3Ie4qf5DqxUS7IJ3Yaj8TL/iyrIfG+Rc3Qx7DPCewYH3V6VaugBAV4ZwFqtNKSkt6zGjrif7dwPzvwYnCQzD8H3s4N2al/CV8eTZ9MfkLUHV26EvJCIq5/kk6iYkb5O/03TFb2ISxzaA6BzdPmk/IQIpnRlq4KST7K39pL46HSqHu1PJXgSDSXZ8pUGHDJ9Rxn2HJq6sitI8cLPVU9XuWXsVOaq8wumn3OtK+4GULdbuwH6vMUY+Q9sd9hCGsSK3KGUY4vcKGnHeizaFjkzMTlKBtUvaWsl0muSyoDT6FiPRRK9INSf1FhrSsdR5aLF1hDzYC9GuPwptOADHLV/lhwi68U7JTnriF3vleztAogluJu+jbzGdsJuciJJd077KlFJB7avCGiRSw9QNMgkKeqiVVIfsgl6eBWn14iIqIpJZ6eA90pnemiur76M4qpnwzVt+fxQ+hsjXr27tRihXgs7xhga0isqi45VyhzPzNcGg8C68bcH2XTnT9gHYLp86lkb9OSTdnGTMZs5c1qs4Iti6gJA7Bp5Psupl5uYHKuXXWQJo7IW5kYvS+Q== ivan-clare_ngong@cc-fd5f12e2-c8cf4f85-mxdnk"
  }
  os_disk {
    caching           = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
}
