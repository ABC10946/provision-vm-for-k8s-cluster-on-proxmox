terraform {
	required_providers {
		proxmox = {
			source = "telmate/proxmox"
			version = "2.9.14"
		}
	}
}

provider "proxmox" {
	pm_user = var.pve_user
	pm_password = var.pve_password
	pm_api_url = "https://actinium.element:8006/api2/json" # <- change it
}
