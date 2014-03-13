#
# Cookbook Name:: rackspace-bootstrap
# Recipe:: setup_iptables_secure_web
#
# This recipe provides the minimum web server configuration firewall settings:
# Serving websites on port 80 and allowing SSH connections.

# Open port 80
iptables_rule "iptables_port_http"

# Open port 22
iptables_rule "iptables_port_ssh"
