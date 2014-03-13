name             'rackspace-bootstrap'
maintainer       'matt surabian'
maintainer_email 'matt@mattsurabian.com'
license          'All rights reserved'
description      'Part of my rackspace kitchen, installs and configures the rackspace cloud backup agent using an encrypted data bag'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

depends 'rackspace-cloud-backup'
