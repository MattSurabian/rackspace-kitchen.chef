custom-apache-config Cookbook
======================
This cookbook sets up a custom apache configuration

Requirements
------------
#### cookbooks
- 'apache2' - for set_apache_conf recipe


Usage
-----
#### custom-config::setup_apache_conf
Set a custon-config domains attribute on your role that is an array of domain names.
When this recipe runs it will setup a custom conf file in apache and create root
directories for dev and prod in /mnt/www/DOMAIN.  Add it to your run list after apache
has been installed.

Example from role:
````
"custom-apache-config":{
               "domains":[
                   "DOMAIN1.com",
                   "DOMAIN2.net",
                   "DOMAIN3.org"
               ]
    }
````

License and Authors
-------------------
Authors: Matt Surabian
