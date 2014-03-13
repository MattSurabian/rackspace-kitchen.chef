#
# Cookbook Name:: rackspace-bootstrap
# Recipe:: setup_rackspace-backup
# See readme for instructions on generating the encrypted data bag
#

rackspace_creds = Chef::EncryptedDataBagItem.load("creds", "rackspace")
node.default['rackspace_cloud_backup']['rackspace_username'] = rackspace_creds['username']
node.default['rackspace_cloud_backup']['rackspace_apikey'] = rackspace_creds['api_key']

include_recipe 'rackspace-cloud-backup::cloud'
