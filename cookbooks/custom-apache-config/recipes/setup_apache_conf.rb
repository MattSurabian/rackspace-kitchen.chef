#
# Cookbook Name:: custom-config
# Recipe:: setup_apache_conf.rb
#

# Apache directory for configuration files
apache_conf_dir = "/etc/apache2/conf.d"
apache_root_dir = "/mnt/www"

# This config uses a non-standard apache directory to store files
# create that root directory

directory "#{apache_root_dir}" do
  owner "www-data"
  group "root"
  mode "0755"
  action :create
end

# Loop through role defined domain array and setup
# a conf file with vhost information and separate directories
# in /mnt/www/

node['custom-apache-config']['domains'].each do |domain|
    directory "#{apache_root_dir}/#{domain}" do
        owner "www-data"
        group "root"
        mode "0755"
        action :create
    end
    directory "#{apache_root_dir}/#{domain}/prod" do
        owner "www-data"
        group "root"
        mode "0755"
        action :create
    end
    directory "#{apache_root_dir}/#{domain}/dev" do
        owner "www-data"
        group "root"
        mode "0755"
        action :create
    end
    template "#{apache_conf_dir}/#{domain}.conf" do
        source "generic.conf.erb"
        owner "root"
        group "root"
        mode "0644"
        variables(
          :domain_name => domain
        )
        notifies:reload, "service[apache2]", :delayed
    end
end
