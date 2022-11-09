auth = {
  user         = "matteo"                   # openstack user
  password     = "ubuntu"                   # user's password
  keystone_url = "https://10.0.0.7:5000/v3" # openstack identity service url
  project      = ""                         # openstack project
  domain       = ""                         # openstack domain
}

network = {
  external_network_id   = "68d5f950-bd27-43b7-8ca6-4fc96341a6dd" #public network id
  external_network_name = "ext_net"                              #public network name
  dns_nameservers       = ["8.8.8.8", "8.8.4.4"]                 # default dns servers
}

compute = {
  image_id  = "76c6c0f5-91cc-4446-bc3f-00bd7ee3fb08" # default compute image id
  flavor_id = "51c1c7b0-1811-4a61-bc55-fb82c86d24cb" # flavor id
  ssh_key   = "MacBook Pro di Matteo"                # ssh key name
}