
variable "vms" {
	type = list
	description = "Vituals Machines"
	 default = [
      {
        name = "master01"
        size = "Standard_A2_v2"
		adddisk = true
      },
      {
        name = "worker01"
        size = "Standard_A2_v2"
		adddisk = false
      }
  ]
}