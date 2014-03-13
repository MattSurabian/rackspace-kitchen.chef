#
# Cookbook Name:: rackspace-cloud-backup
# Recipe:: default
#
# Copyright 2013, Rackspace US, Inc.
#
# Apache 2.0
#
case node[:platform]
  when "redhat", "centos"
    yum_repository "cloud-backup" do
      description "Rackspace cloud backup agent repo"
      url "http://agentrepo.drivesrvr.com/redhat/"
  end
  when "ubuntu","debian"
    apt_repository "cloud-backup" do
      uri "http://agentrepo.drivesrvr.com/debian/"
      arch "amd64"
      distribution "serveragent"
      components ["main"]
      key "http://agentrepo.drivesrvr.com/debian/agentrepo.key"
      action :add
  end
end

package "driveclient" do
  action :upgrade
end

unless node['rackspace_cloud_backup']['rackspace_username'].nil?
  unless node['rackspace_cloud_backup']['rackspace_apikey'].nil?
    execute "registration" do
      command "driveclient -c -u #{node['rackspace_cloud_backup']['rackspace_username']} -k #{node['rackspace_cloud_backup']['rackspace_apikey']} && touch /etc/driveclient/.registered"
      creates "/etc/driveclient/.registered"
      action :run
      notifies :restart, "service[driveclient]"
    end
  end
end

service "driveclient" do
  action :enable
end

#insert the backup creation script
cookbook_file "/etc/driveclient/auth.py" do
  source "auth.py"
  mode 00755
  owner "root"
  group "root"
end
cookbook_file "/etc/driveclient/create-backup.py" do
  source "create_backup.py"
  mode 00755
  owner "root"
  group "root"
end

#create the backup
if node['rackspace_cloud_backup']['rackspace_username'] && node['rackspace_cloud_backup']['rackspace_apikey'] && node['rackspace_cloud_backup']['cloud_notify_email'] && node['rackspace_cloud_backup']['backup_locations']
  for location in node['rackspace_cloud_backup']['backup_locations'] do
    execute "create backup" do
      command "/etc/driveclient/create-backup.py -u #{node['rackspace_cloud_backup']['rackspace_username']} -a #{node['rackspace_cloud_backup']['rackspace_apikey']} -d #{location} -e #{node['rackspace_cloud_backup']['cloud_notify_email']} -i #{node['ipaddress']} >> /etc/driveclient/run_backup"
      creates "/etc/driveclient/backups_created"
      action :run
    end
  end
  file "/etc/driveclient/backups_created" do
    owner "root"
    group "root"
    mode "0444"
    action :touch
  end
  cron "cloud-backup-trigger" do
    if node['rackspace_cloud_backup']['backup_cron_day']
      day node['rackspace_cloud_backup']['backup_cron_day']
    end
    if node['rackspace_cloud_backup']['backup_cron_hour']
      hour node['rackspace_cloud_backup']['backup_cron_hour']
    end
    if node['rackspace_cloud_backup']['backup_cron_minute']
      minute node['rackspace_cloud_backup']['backup_cron_minute']
    end
    if node['rackspace_cloud_backup']['backup_cron_month']
      month node['rackspace_cloud_backup']['backup_cron_month']
    end
    if node['rackspace_cloud_backup']['backup_cron_weekday']
      weekday node['rackspace_cloud_backup']['backup_cron_weekday']
    end
    if node['rackspace_cloud_backup']['backup_cron_user']
      user node['rackspace_cloud_backup']['backup_cron_user']
    end
    if node['rackspace_cloud_backup']['backup_cron_mailto']
      mailto node['rackspace_cloud_backup']['backup_cron_mailto']
    end
    if node['rackspace_cloud_backup']['backup_cron_path']
      path node['rackspace_cloud_backup']['backup_cron_path']
    end
    if node['rackspace_cloud_backup']['backup_cron_shell']
      shell node['rackspace_cloud_backup']['backup_cron_shell']
    end
    if node['rackspace_cloud_backup']['backup_cron_home']
      home node['rackspace_cloud_backup']['backup_cron_home']
    end
    command "/bin/bash /etc/driveclient/run_backup"
    action :create
  end
end
