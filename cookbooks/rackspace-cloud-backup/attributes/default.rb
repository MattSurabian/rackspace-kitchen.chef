#
# Cookbook Name:: rackspace-cloud-backup
# Attributes:: default 
#
# Copyright:: 2013, Rackspace US, inc. <matt.thode@rackspace.com>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

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
