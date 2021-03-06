# # Cookbook Name:: cdh3
# Recipe:: hadoop
#
# Copyright 2011, Space Rock Duck Velociraptor
#
# All rights reserved - Do Not Redistribute
#
include_recipe "cdh3::default"

package 'hadoop-0.20'

if node[:hue][:enabled]
    package 'hue-plugins'
end

# get the address of the job tracker
search(:node, "role:job_tracker") do |node|
    %w(hdfs-site.xml masters mapred-site.xml).each do |config|
        template "/etc/hadoop/conf/#{config}" do
            source "#{config}"
            owner "hdfs"
            group "hadoop"
            variables(:master_ip => node.ipaddress)
        end
    end
end

# get the address of the name node
search(:node, "role:name_node") do |node|
    template "/etc/hadoop/conf/core-site.xml" do
        source "core-site.xml"
        owner "hdfs"
        group "hadoop"
        variables(:name_node_ip => node.ipaddress)
    end
end

# get the addresses of the slaves
slave_ips = search(:node, "role:compute_node").map { |node| node.ipaddress }
template "/etc/hadoop/conf/slaves" do
    source "slaves"
    owner "hdfs"
    group "hadoop"
    variables(:slave_ips => slave_ips)
end

# dfs specific dirs
# TODO: these should be the same as in hdfs-site.xml
%w(name data).each do |dir|
    directory "/space/hadoop/dfs/#{dir}" do
        owner "hdfs"
        group "hadoop"
        recursive true
    end
end

# mapred specific dirs
# TODO: these should be the same as in mapred-site.xml
%w(local temp).each do |dir|
    directory "/space/hadoop/mapred/#{dir}" do
        owner "mapred"
        group "hadoop"
        recursive true
    end
end

execute "sudo chgrp -R hadoop /etc/hadoop/conf/"
execute "sudo chmod -R g+r /etc/hadoop/conf/"
execute "sudo chown -R mapred:hadoop /var/log/hadoop-0.20/"
execute "sudo chmod g+w /var/log/hadoop-0.20"
