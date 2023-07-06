output "loadbalancer_ip" {
  value = openstack_networking_floatingip_v2.web_lb_floating_ip.address
}

output "instances_info" {
  description = "Instances Informations"
  value = [for instance in openstack_compute_instance_v2.web-server : {
    id   = instance.id
    name = instance.name
    ip   = instance.network[0].fixed_ip_v4
  }]
}