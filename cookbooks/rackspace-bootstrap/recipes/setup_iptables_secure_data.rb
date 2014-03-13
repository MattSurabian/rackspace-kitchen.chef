#
# Cookbook Name:: rackspace-bootstrap
# Recipe:: setup_iptables_secure_data
#
# This recipe provides the minimum data server configuration firewall settings:
# Serving mysql on port 3306 and allowing SSH connections.

# Open port 3306
iptables_rule "iptables_port_mysql"

# Open port 22
iptables_rule "iptables_port_ssh"

# Open port 6379
iptables_rule "iptables_port_redisio"
