# # Cookbook Name:: cdh3
# Recipe:: default
#
# Copyright 2011, Space Rock Duck Velociraptor
#
# All rights reserved - Do Not Redistribute
#
include_recipe "java::sun"

execute "add cloudera repo" do
    command 'sudo wget "http://archive.cloudera.com/redhat/cdh/cloudera-cdh3.repo"'
    cwd '/etc/yum.repos.d/'
    creates '/etc/yum.repos.d/cloudera-cdh3.repo'
end

execute 'sudo yum update yum -y'
