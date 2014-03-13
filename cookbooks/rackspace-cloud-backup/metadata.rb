name             'rackspace-cloud-backup'
maintainer       'Rackspace US, Inc.'
maintainer_email 'matt.thode@rackspace.com'
license          'Apache 2.0'
description      'Installs/Configures rackspace-cloud-backup'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.3.2'

recipe           "rackspace-cloud-backup", "Installs and registers cloud backup"

depends "apt"
depends "yum"
