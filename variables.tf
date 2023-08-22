variable "hosts" {
	type = list(object({
		hostname = string
		ip_address = string
	}))
	default = [
		{
 			hostname = "k8s-master1"
 			ip_address = "192.168.3.91"
 		},
 		{
 			hostname = "k8s-worker1"
 			ip_address = "192.168.3.92"
 		},
 		{
 			hostname = "k8s-worker2"
 			ip_address = "192.168.3.93"
 		},
		{
			hostname = "k8s-vTM"
			ip_address = "192.168.3.94"
		}
	]
}
