# # Cookbook Name:: cdh3
# Recipe:: hadoop-namenode
#
# Copyright 2011, Space Rock Duck Velociraptor
#
# All rights reserved - Do Not Redistribute
#
include_recipe "cdh3::hadoop"

package "hadoop-0.20-namenode"

service "hadoop-0.20-namenode" do
    supports :status => true, :start => true, :stop => true, :restart => true
    action [:enable, :start]
end

