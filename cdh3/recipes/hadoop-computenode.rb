# # Cookbook Name:: cdh3
# Recipe:: hadoop-computenode
#
# Copyright 2011, Space Rock Duck Velociraptor
#
# All rights reserved - Do Not Redistribute
#
include_recipe "cdh3::hadoop"

%w(datanode tasktracker).each do |service|
    package "hadoop-0.20-#{service}"

    service "hadoop-0.20-#{service}" do
        supports :status => true, :start => true, :stop => true, :restart => true
        action [:enable, :start]
    end
end
