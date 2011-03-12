maintainer       "Space Rock Duck Velociraptor"
maintainer_email "samneubardt@gmail.com"
license          "All rights reserved"
description      "Installs/Configures Cloudera cdh3"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.rdoc'))
version          "0.0.1"
supports 'centos'

recipe            "cdh3", "Install hadoop"
recipe            "cdh3::hue", "Install hue"

attribute "hue/enabled",
  :display_name => "Hue Enabled",
  :description => "Should Hue be installed on the cluster?",
  :type => "string"

attribute "hue/secret_key",
  :display_name => "Secret Key",
  :description =>  "The secret key for Hue",
  :type => "string"
