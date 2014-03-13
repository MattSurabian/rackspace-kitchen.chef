#
# Cookbook Name:: rackspace-cloud-backup
# Recipe:: default
#
# Copyright 2013, Rackspace US, Inc.
#
# Apache 2.0
#
#set up repos
case node[:platform]
  when "redhat", "centos"
    yum_key "GPG-KEY-rackops" do
      url "http://repo.rackops.org/rackops-signing-key.asc"
      action :add
    end
    yum_repository "rackops-repo" do
      description "Rackspace rackops repo"
      url "http://repo.rackops.org/rpm/"
	key "GPG-KEY-rackops"
  end
  when "ubuntu","debian"
    case node["lsb"][:codename]
    when "precise"
      apt_repository "rackops-repo" do
        uri "http://repo.rackops.org/apt/ubuntu"
        distribution "precise"
        components ["main"]
        key "http://repo.rackops.org/rackops-signing-key.asc"
        action :add
    end
    when "wheezy"
      apt_repository "rackops-repo" do
        uri "http://repo.rackops.org/apt/debian"
        distribution "wheezy"
        components ["main"]
        key "http://repo.rackops.org/rackops-signing-key.asc"
        action :add
    end
  end
end

#install turbolift
case node[:platform]
  when "redhat", "centos"
    package "python-turbolift" do
      action :upgrade
  end
  when "ubuntu","debian"
    package "python-turbolift" do
      #options "--allow-unauthenticated"
      action :upgrade
  end
end

#set up cronjob
if node['rackspace_cloud_backup']['backup_locations'] && node['rackspace_cloud_backup']['backup_container'] && node['rackspace_cloud_backup']['rackspace_endpoint'] && node['rackspace_cloud_backup']['rackspace_apikey'] && node['rackspace_cloud_backup']['rackspace_username']
 for location in node['rackspace_cloud_backup']['backup_locations'] do
  cron "turbolift-#{location}" do
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
    command "time=$(date +\\%Y-\\%m-\\%d_\\%H:\\%M:\\%S); turbolift --os-rax-auth #{node['rackspace_cloud_backup']['rackspace_endpoint']} -u #{node['rackspace_cloud_backup']['rackspace_username']} -a #{node['rackspace_cloud_backup']['rackspace_apikey']} archive -s #{location} -c #{node['rackspace_cloud_backup']['backup_container']} --verify --tar-name \"${time} - #{location.gsub('/', '___')}\""
    action :create
  end
 end
end
