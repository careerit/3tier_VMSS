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



variable "bastion_vm_size" {
  description = "Size of the db Nodes"
}

variable "web_default_vms" {
  description = "Default number of instances in Web VMSS"
  default = 1
}

variable "web_minimum_vms" {
  description = "Minuimum number of instances in Web VMSS"
  default = 2
}

variable "web_maximum_vms" {
  description = "Maximum number of instances in Web VMSS"
  default = 4
}


variable "web_vm_size" {
  description = "Size of the db Nodes"
}

variable "application_port" {
  description  =  "Port on which App is exposed to LB"

}

variable "db_node_count" {
}


variable "db_vm_size" {
  description = "Size of the db Nodes"
}

variable "destination_ssh_key_path" {
  description = "Path where ssh keys are copied in the vm. Only /home/<username>/.ssh/authorize_keys is accepted."
}

variable "bastion_inbound_ports" {
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
