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

execute 'install jython' do
    command 'java -jar jython_installer-2.5.2.jar -s -d /usr/local/share/java/srdv/ -e demo,doc,src'
    cwd '/tmp'
end
