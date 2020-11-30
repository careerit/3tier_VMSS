variable "prefix" {
}

// variable "virtual_machine_name" {
// }

variable "location" {
}

variable "username" {
}

// variable "susbcription_id" {
// }



variable "ansible_vm_size" {
  description = "Size of the db Nodes"
}


variable "application_port" {
  description  =  "Port on which App is exposed to LB"

}


variable "win_node_count" {
  description = "Number of Windows VMs"
  default = 1
}


variable "win_inbound_ports" {
  type = list(string)
}
variable "win_vm_size" {
  description = "Size of the Windows Machine"
  default = "Standard_B1s"
}

variable "password" {
  description = "Password for Windows instance"
  default = "StraangP@55Kee"
}


variable "web_node_count" {
}

variable "web_vm_size" {
  description = "Size of the web Machine"
  default = "Standard_B1s"
}

variable "db_node_count" {
}


variable "db_vm_size" {
  description = "Size of the db Nodes"
}

variable "destination_ssh_key_path" {
  description = "Path where ssh keys are copied in the vm. Only /home/<username>/.ssh/authorize_keys is accepted."
}

variable "ansible_inbound_ports" {
  type = list(string)
}

variable "web_inbound_ports" {
  type = list(string)
}


variable "db_inbound_ports" {
  type = list(string)
}

variable "tags" {
  type = map(string)

  default = {
    name = "k8s"
  }

  description = "Any tags which should be assigned to the resources in this example"
}
