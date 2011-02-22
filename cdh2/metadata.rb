maintainer       "Space Rock Duck Velociraptor"
maintainer_email "samneubardt@gmail.com"
license          "All rights reserved"
description      "Installs/Configures Cloudera cdh2"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.rdoc'))
version          "0.0.1"

attribute "master_ip",
  :display_name => "Master IP Address",
  :description => "The IP Address of the Master",
  :type => "string"

attribute "slave_ips",
  :display_name => "Slave IP Addresses",
  :description => "The IP Addresses of the Slaves",
  :type => "array"
