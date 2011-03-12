# # Cookbook Name:: cdh3
# Recipe:: default
#
# Copyright 2011, Space Rock Duck Velociraptor
#
# All rights reserved - Do Not Redistribute
#
include_recipe "cdh3::default"

package 'hue'

template '/etc/hue/hue.ini' do
  source 'hue.ini'
  owner 'hue'
  group 'hadoop'
  variables(:namenode => search(:node, "role:name_node").first.ipaddress,
            :jobtracker => search(:node, "role:job_tracker").first.ipaddress)
end

service 'hue' do
    supports :status => true, :start => true, :stop => true, :restart => true
    action [:enable, :start]
end
