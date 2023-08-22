resource "local_file" "cloud_init_user_data_file" {
	content = file("${path.module}/userdata/adduser.yaml")
	filename = "${path.module}/userdata/adduser.yaml"
}

resource "null_resource" "cloud_init_config" {
	connection {
		type = "ssh"
		user = var.proxmox_ssh_user
		password = var.proxmox_ssh_password
		host = "192.168.3.80"
	}

	provisioner "file" {
	    content = local_file.cloud_init_user_data_file.content
	    destination = "/var/lib/vz/snippets/adduser.yaml"
	}
}

resource "proxmox_vm_qemu" "k8s-vm" {
	for_each = {for i in var.hosts: i.hostname => i}

	depends_on = [
		null_resource.cloud_init_config
	]

	name = "${each.value.hostname}"
	target_node = "actinium"
	clone = "ubuntu-template"
	onboot = true
	cores = 2

	cicustom = "user=local:snippets/adduser.yaml"

	disk {
		type = "sata"
		storage = "vm_strg"
		size = "40G"
	}
	memory = 4096

	ipconfig0 = "ip=${each.value.ip_address}/24,gw=192.168.3.1"
}
