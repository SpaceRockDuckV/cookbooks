#
# Cookbook Name:: jython
# Recipe:: default
#
# Copyright 2011, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'java::sun'

execute 'retrieve installation jar' do
  command 'wget "http://downloads.sourceforge.net/project/jython/jython/2.5.2/jython_installer-2.5.2.jar?r=http%3A%2F%2Fwww.jython.org%2Fdownloads.html&ts=1302018977&use_mirror=superb-sea2"'
  cwd '/tmp'
  creates '/tmp/jython_installer-2.5.2.jar'
end

directory '/usr/local/share/java/srdv/jython' do
  action :create
  owner 'mapred'
  group 'hadoop'
  mode '0775'
  recursive true
  creates '/usr/local/share/java/srdv/'
end

execute 'install jython' do
  command 'sudo java -jar jython_installer-2.5.2.jar -s -d /usr/local/share/java/srdv/jython -e demo doc src'
  cwd '/tmp'
  creates '/usr/local/share/java/srdv/jython/jython'
end
