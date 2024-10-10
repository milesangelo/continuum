datacenter = "dc1"
data_dir = "/var/lib/consul"
log_level = "INFO"
node_name = "nomad-client"
server = false  # Set true if configuring a Consul server

client_addr = "0.0.0.0"

# Enable Nomad integration
service {
  name = "nomad"
  port = 4646
  tags = ["leader"]
}