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

package 'hadoop-0.20'

cookbook_file "/etc/hadoop/conf/hdfs-site.xml" do
    source "hdfs-site.xml"
    owner "hadoop"
end

# get the address of the job tracker
search(:node, "role:job_tracker") do |node|
    template "/etc/hadoop/conf/masters" do
        source "masters"
        owner "hadoop"
        variables(:master_ip => node.ipaddress)
    end

    template "/etc/hadoop/conf/mapred-site.xml" do
        source "mapred-site.xml"
        owner "hadoop"
        variables(:master_ip => node.ipaddress)
    end
end

# get the address of the name node
search(:node, "role:name_node") do |node|
    template "/etc/hadoop/conf/core-site.xml" do
        source "core-site.xml"
        owner "hadoop"
        variables(:name_node_ip => node.ipaddress)
    end
end

# get the addresses of the slaves
slave_ips = search(:node, "role:compute_node").map { |node| node.ipaddress }
template "/etc/hadoop/conf/slaves" do
    source "slaves"
    owner "hadoop"
    variables(:slave_ips => slave_ips)
end

# dfs specific dirs
%w(name data).each do |dir|
    directory "/space/hadoop/dfs/#{dir}" do
        owner "hadoop"
        recursive true
    end
end

# mapred specific dirs
%w(local temp).each do |dir|
    directory "/space/hadoop/mapred/#{dir}" do
        owner "hadoop"
        recursive true
    end
end

service "hadoop-0.20-namenode" do
    only_if {node.roles.include? 'name_node'}
    supports :status => true, :start => true, :stop => true, :restart => true
    action [:enable, :start]
end

service "hadoop-0.20-jobtracker" do
    only_if {node.roles.include? 'job_tracker'}
    supports :status => true, :start => true, :stop => true, :restart => true
    action [:enable, :start]
end

service "hadoop-0.20-datanode" do
    only_if {node.roles.include? 'compute_node'}
    supports :status => true, :start => true, :stop => true, :restart => true
    action [:enable, :start]
end

service "hadoop-0.20-tasktracker" do
    only_if {node.roles.include? 'compute_node'}
    supports :status => true, :start => true, :stop => true, :restart => true
    action [:enable, :start]
end
