# # Cookbook Name:: cdh2
# Recipe:: default
#
# Copyright 2011, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

execute "add cloudera repo" do
    command 'sudo wget "http://archive.cloudera.com/redhat/cdh/cloudera-cdh2.repo"'
    cwd '/etc/yum.repos.d/'
    creates 'cloudera-cdh2.repo'
end

execute 'sudo yum update yum -y'

package 'hadoop-0.20'


%w(mapred hdfs core).each do |conf|
    cookbook_file "/etc/hadoop/conf/#{conf}-site.xml" do
        source "#{conf}-site.xml"
        owner "hadoop"
    end
end

# get the address of the master
search(:node, "role:job_tracker") do |node|
    template "/etc/hadoop/conf/masters" do
        source "masters"
        owner "hadoop"
        variables(:master_ip => node.ipaddress)
    end
end

# get the address of the master
slave_ips = search(:node, "role:compute_node").map { |node| node.ipaddress }
template "/etc/hadoop/conf/slaves" do
    source "slaves"
    owner "hadoop"
    variables(:slave_ips => slave_ips)
end

# dfs specific dirs
%w(name data).each do |dir|
    directory "/usr/lib/hadoop/dfs/#{dir}" do
        owner "hadoop"
        recursive true
    end
end

# mapred specific dirs
%w(local temp).each do |dir|
    directory "/usr/lib/hadoop/mapred/#{dir}" do
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
