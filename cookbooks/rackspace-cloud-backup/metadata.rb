maintainer       "Trond Arve Nordheim"
maintainer_email "t@binarymarbles.com"
license          "Apache 2.0"
description      "Installs and configures the Rackspace Cloud backup agent."
long_description IO.read(File.join(File.dirname(__FILE__), "README.md"))
version          "1.0.0"

%w(ubuntu debian).each do |platform|
  supports platform
end

recipe           "rackspace_cloud_backup", "Installs and configures the Rackspace Cloud backup agent."

attribute "rackspace_cloud_backup",
  :display_name => "Rackspace Cloud Backup",
  :description => "Hash of Rackspace Cloud Backup attributes.",
  :type => "hash"

attribute "rackspace_cloud_backup/username",
  :display_name => "Username",
  :description => "Rackspace username",
  :default => ""

attribute "rackspace_cloud_backup/api_key",
  :display_name => "API key",
  :description => "Rackspace API key",
  :default => ""
