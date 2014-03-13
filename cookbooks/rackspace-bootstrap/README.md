rackspace-bootstrap Cookbook
============================
This cookbook installs and configures the rackspace cloud backup agent using
an encrypted databag to store api creds.

Requirements
------------

### Secret Key

 You'll need a secret key called `encrypted_data_bag_secret` within the containing repos .chef file.
 This can be generated with the command (should be run from root of repository, not from within this cookbook):

 ```
 openssl rand -base64 512 | tr -d '\r\n' > .chef/encrypted_data_bag_secret
 ```

 The default key name is used and should be configured in knife so it is automatically added to bootstrapped nodes
 Add to knife.rb: `knife[:secret_file] = ".chef/encrypted_data_bag_secret"`

### Encrypted Data Bag

 Create an encrypted data bag using the generated secret:

 `knife data bag create creds rackspace --secret-file .chef/encrypted_data_bag_secret`

 1. This will open an editor where you create a json object containing your credentials. It should look like this:

```
{
"id": "rackspace",
"username": "<YOUR RACKSPACE USERNAME>",
"api_key":  "<YOUR RACKSPACE API KEY"
}
```
Upon exiting the editor your databag should be saved and uploaded to the chef server. You can confirm it worked with this command: `knife data bag show creds rackspace`

**Note:** *Because we're specifying our secret key in the knife.rb as configured in the prequisite step, you should be able to see the data bag contents in plain text. Comment out the secret_file config in knife.rb and run the same command to see the encrypted output as it exists on the chef server.*


### Cookbooks
 - rackspace-cloud-backup
 - iptables


Usage
-----

#### rackspace-bootstrap::default
noop

#### rackspace-bootstrap::setup_rackspace_backup
Uses the configured encrypted data bag credentials to instal and register the rackspace backup agent

#### rackspace-bootstrap::setup_iptables_secure_data
Uses iptables_rule to open ports: 3306, 22, 6379

#### rackspace-bootstrap::setup_iptables_secure_web
Uses iptables_tule to open ports: 80, 22

#### Templates
Templates are provided to aid in further iptable configuration see setup_iptables recipes to see how they can be used

License and Authors
-------------------
License: MIT
Authors: Matt Surabian
