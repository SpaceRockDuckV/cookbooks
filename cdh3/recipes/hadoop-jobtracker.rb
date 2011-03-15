# # Cookbook Name:: cdh3
# Recipe:: hadoop-jobtracker
#
# Copyright 2011, Space Rock Duck Velociraptor
#
# All rights reserved - Do Not Redistribute
#
include_recipe "cdh3::hadoop"

package "hadoop-0.20-jobtracker"

service "hadoop-0.20-jobtracker" do
    supports :status => true, :start => true, :stop => true, :restart => true
    action [:enable, :start]
end
