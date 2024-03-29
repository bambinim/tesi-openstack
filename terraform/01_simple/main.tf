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
  user_name   = "user"
  password    = "password"
  auth_url    = "https://10.0.0.7:5000/v3" # keystone endpoint URL
  domain_name = "domain"
  tenant_name = "project1" # project name
  insecure    = true       # allow self-signed SSL cert
}

resource "openstack_compute_instance_v2" "test-server" {
  name            = "test-server"
  image_id        = "f2aa2ed8-cb58-4152-b881-5e3a3c24fe30"
  flavor_id       = "cf492d92-2496-4f62-9f3f-d160758c812c"
  key_pair        = "terraform"
  security_groups = ["default"]

  network {
    name = "internal"
  }
}