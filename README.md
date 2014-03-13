About The Rackspace Kitchen
========
Assembled by: Matt Surabian
Email: matt@mattsurabian.com

This is the repo that contains all the cookbooks and roles I use to configure my personal cloud servers on RackSpace.
Personally I use a separate web and data server setup, so I can scale either behind a load balancer if necessary.
I've added a LAMP server role for convenience to others that just want a quick way to leverage chef and create
a standard LAMP environment within the RackSpace OpenCloud.

It has been updated to play nice with the latest Chef, use Berkshelf to control dependencies, and store RackSpace credentials in an encrypted data bag per best practices.

Feel free to open issues in this repo or email me if you hit any roadblocks.

Prerequisites
=============
 * Your workstation is setup with Chef http://docs.opscode.com/install_workstation.html
 * [Bundler](http://bundler.io/) is installed `gem install bundler`
 * A hosted chef account at OpsCode
 * A .chef folder in this repo containing your knife.rb file, which is setup to point to the location of your .pem file and validator.pem file both downloadable from OpsCode
 * Environment variables set for your RACKSPACE_USERNAME, and RACKSPACE_API_KEY.  I set them in my .bash_profile as follows

 ````
 export RACKSPACE_USERNAME=<RACKSPACE USERNAME>
 export RACKSPACE_API_KEY=<RACKSPACE API>
 ````
 * A secret key called `encrypted_data_bag_secret` within this repos .chef file. Which can be generated with this command:

 ```
 openssl rand -base64 512 | tr -d '\r\n' > .chef/encrypted_data_bag_secret
 ```

 * The following lines in your knife.rb file

````
cookbook_path            'cookbooks/'
knife[:secret_file] = ".chef/encrypted_data_bag_secret"
knife[:rackspace_api_username] = "#{ENV['RACKSPACE_USERNAME']}"
knife[:rackspace_api_key] = "#{ENV['RACKSPACE_API_KEY']}"
knife[:rackspace_version] = 'v2'
knife[:rackspace_region] = "ord"

````
*Note: you may want to adjust the rackspace_region to suit your location*

Getting Started
===============
This project has been updated to use [bundler](http:bundler.io) and [berkshelf 3](http://berkshelf.com/)! So first we'll need to install all the dependencies! If you're not familiar with these projects it might help to do a little reading on their documentation sites.

**Let's install some dependencies:**

1. `bundle install`
1. `bundle exec berks install`

**Let's make some encrypted data bags for our Rackspace creds**

We're going to put that key we generated in the prequisite section to good use! The `rackspace-bootstrap` cookbook provides a recipe called `setup-rackspace-backup`, which requires access to your rackspace username and api key. Previous versions of this repo required manual editing of the roles files to provide credentials.

But those days are gone, as storing creds like that may result in accidently committing credentials into version control. Encrypted data bags prevent that issue completely.  So let's get to it!

1. Create your Rackspace creds data bag `knife data bag create creds rackspace --secret-file .chef/encrypted_data_bag_secret`
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




Usage
=====
Ensure you have followed the prerequisite steps and can access your OpsCode hosted chef server using knife.

If you've made modifications to the cookbooks update your metadata
````
knife cookbook metadata -a
````

Upload all dependent cookbooks to your chef server

````
bundle exec berks upload
````
*[There is an issue with ulimit 0.3.2 if you run into trouble uploading it, check here for the solution](https://github.com/berkshelf/berkshelf/issues/1019)*

Upload the rackspace-bootstrap and custom-apache-config cookbooks to the chef server

```
knife cookbook upload -a
```

Upload the roles you'd like to use to your chef server
````
knife role from file roles/data_server.json
knife role from file roles/web_server.json
knife role from file roles/lamp_server.json
````

Use the knife rackspace plugin to fire up a new server! (the image hash used corresponds to Ubuntu 12 LTS)
````
knife rackspace server create -r 'role[webserver]' --server-name WebServer --node-name WebServer --image 5cebb13a-f783-4f8c-8058-c4182c724ccd --flavor 2
````
or for a dataserver
````
knife rackspace server create -r 'role[dataserver]' --server-name DataServer --node-name DataServer --image 5cebb13a-f783-4f8c-8058-c4182c724ccd --flavor 2
````
or for a lamp
````
knife rackspace server create -r 'role[lampserver]' --server-name LampServer --node-name LampServer --image 5cebb13a-f783-4f8c-8058-c4182c724ccd --flavor 2
````
If something goes wrong and you want to remove the server you can do so through the GUI's in RackSpace
 AND OpsCode, you can also use knife
````
knife rackspace server list
knife rackspace server delete <ID OF THE SERVER TO DELETE FROM THE LIST>
knife client delete NODE-NAME (used in the server create method above)
knife node delete NODE-NAME (used in the server create method above)
````

Roles
=====
The roles included cover my basic server setup and are in no way exhaustive.  You should modify the roles to suit your needs.
All of the roles provided here configure the RackSpace backup client, if you don't want that to happen modify the runlist. In order for the backup client to be properly configured you'll need to follow the above instructions on creating a key and encrypted data bag.  Check the README inside the roles directory for more details on the provided roles.

Passwords and Access
====================
The knife rackspace command will output the node's root password when the server has been configured.
The mysql root password can be copied from the /etc/mysql/grants.sql file


Next Steps
==========

Read the README file in each of the subdirectories and cookbooks for more information.
