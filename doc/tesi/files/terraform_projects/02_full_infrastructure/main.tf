terraform {
  required_version = ">= 0.14.0"
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 1.48.0"
    }
  }
}


provider "openstack" {
  user_name   = var.auth.user
  password    = var.auth.password
  auth_url    = var.auth.keystone_url
  domain_name = var.auth.domain
  tenant_name = var.auth.project # project name
  insecure    = true             # allow self-signed SSL cert
}

variable "auth" {
  type = object({
    user         = string
    password     = string
    keystone_url = string
    project      = string
    domain       = string
  })
}

variable "network" {
  type = object({
    external_network_id   = string
    external_network_name = string
    dns_nameservers       = list(string)
  })
}

variable "compute" {
  type = object({
    image_id  = string
    flavor_id = string
    ssh_key   = string
  })
}