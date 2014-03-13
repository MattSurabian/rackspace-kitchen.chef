Don't forget to set your RackSpace username and API key in the role files!
Otherwise you won't be able to install/configure the rackspace-cloud-backup client

The webserver role includes an override attribute to configure custom apache .conf files and prod and dev
directories inside /mnt/www/DOMAIN just provide a list of all the domains this server is meant to host.

data_server.json
================

This runlist updates the apt repository, installs mysql client and server, installs and enables redis,
installs and configures the RackSpace backup client, installs IP tables and opens ports: 3306, 22, 6379.

lamp_server.json
================

This role is basically a combo of the web server and the data server.
The LAMP server does NOT have redis installed by default.  Though the redis port is open.


web_server.json
===============

This is NOT configured by default to terminate SSL via https.

This runlist updates the apt repository, installs apache, php, phpmysql, sets up /mnt/www/DOMAIN directories
for prod and dev environments for any domain configured as an overridden attribute in the role's JSON and
configures separate .conf files for each domain in /etc/apache/conf.d/.  Next git is installed along with
nodejs and the RackSpace backup client.  Iptables is installed and configured opening only port 80 and 22.


To upload roles to the Chef Server:

    knife role from file roles/FILENAME
