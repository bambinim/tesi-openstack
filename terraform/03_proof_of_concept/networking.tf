resource "openstack_networking_network_v2" "web_private" {
  name           = "web_private"
  admin_state_up = "true"
}

resource "openstack_networking_subnet_v2" "web_private_subnet" {
  name            = "web_private_subnet"
  network_id      = openstack_networking_network_v2.web_private.id
  ip_version      = 4
  cidr            = "192.168.1.0/24"
  gateway_ip      = "192.168.1.1"
  dns_nameservers = var.network.dns_nameservers
}

resource "openstack_compute_secgroup_v2" "web_secgroup" {
  name        = "web_secgroup"
  description = "Terraform security group"

  rule {
    from_port   = 22
    to_port     = 22
    ip_protocol = "tcp"
    cidr        = "0.0.0.0/0"
  }

  rule {
    from_port   = 80
    to_port     = 80
    ip_protocol = "tcp"
    cidr        = "0.0.0.0/0"
  }
}

resource "openstack_networking_router_v2" "web_router" {
  name                = "web_router"
  admin_state_up      = true
  external_network_id = var.network.external_network_id
}

resource "openstack_networking_router_interface_v2" "web_router_interface" {
  router_id = openstack_networking_router_v2.web_router.id
  subnet_id = openstack_networking_subnet_v2.web_private_subnet.id
}