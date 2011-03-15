# # Cookbook Name:: cdh3
# Recipe:: zookeeper
#
# Copyright 2011, Space Rock Duck Velociraptor
#
# All rights reserved - Do Not Redistribute
#
include_recipe "cdh3::default"

package "hadoop-zookeeper-server"

service "hadoop-zookeeper" do
    supports :status => true, :start => true, :stop => true, :restart => true
    action [:enable, :start]
end
