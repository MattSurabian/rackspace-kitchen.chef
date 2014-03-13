rackspace-cloud-backup Cookbook
===============================
This cookbook will install the Rackspace Cloud Backup agent and register it based on the credentials found in
node['rackspace_cloud_backup']['rackspace_username'] and node['rackspace_cloud_backup']['rackspace_apikey']

------------
Requires Apt and Yum

Attributes
----------
    default[:rackspace_cloud_backup][:rackspace_username] = nil
    default[:rackspace_cloud_backup][:rackspace_apikey] = nil
    default[:rackspace_cloud_backup][:rackspace_endpoint] = "dfw"
    default[:rackspace_cloud_backup][:backup_locations] = nil
    default[:rackspace_cloud_backup][:backup_container] = nil
    default[:rackspace_cloud_backup][:backup_cron_day] = "*"
    default[:rackspace_cloud_backup][:backup_cron_hour] = "3"
    default[:rackspace_cloud_backup][:backup_cron_minute] = "14"
    default[:rackspace_cloud_backup][:backup_cron_month] = "*"
    default[:rackspace_cloud_backup][:backup_cron_weekday] = "*"
    default[:rackspace_cloud_backup][:backup_cron_user] = nil
    default[:rackspace_cloud_backup][:backup_cron_mailto] = nil
    default[:rackspace_cloud_backup][:backup_cron_path] = nil
    default[:rackspace_cloud_backup][:backup_cron_shell] = nil
    default[:rackspace_cloud_backup][:backup_cron_home] = nil
    default[:rackspace_cloud_backup][:cloud_notify_email] = nil

Usage
-----
#### rackspace-cloud-backup::default
Just set the environment variables for the rackspace_username and rackspace_apikey attributes

Here's an example of some environment variables for if it used turbolift

    "rackspace_cloud_backup": {
      "backup_cron_hour": "*",
      "backup_cron_day": "*",
      "rackspace_username": "exampleuser",
      "rackspace_endpoint": "dfw",
      "backup_locations": [
        "/root/files",
        "/etc/init.d"
      ],
      "backup_cron_user": "root",
      "backup_cron_weekday": "*",
      "backup_container": "ubuntu-test-turbolift",
      "rackspace_apikey": "lolnopenotgonnahappen",
      "backup_cron_month": "*",
      "backup_cron_minute": "50"
      "cloud_notify_email" = "email@example.com"
    }

##### rackspace-cloud-backup::cloud
This recipe calls cloud backup to install, register and register it's backups.
It also creats a simple cron job that will call for the backup to run.

##### rackspace-cloud-backup::not\_cloud
This recipe calls for turbolift to install, and creates cron-jobs that upload the directories you wish to back up to cloud files.

Contributing
------------
Please see https://github.com/rackspace-cookbooks/contributing for how to contribute.

License and Authors
-------------------
License: Apache 2.0
Authors: Matthew Thode (prometheanfire)
