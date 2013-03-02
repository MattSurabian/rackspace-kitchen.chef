#
# Cookbook Name:: iptables
# Recipe:: secure_web_config
#
# This recipe provides the minimum web server configuration firewall settings:
# Serving websites on port 80 and allowing SSH connections.

# Open port 80
iptables_rule "port_http"

# Open port 22
iptables_rule "port_ssh"