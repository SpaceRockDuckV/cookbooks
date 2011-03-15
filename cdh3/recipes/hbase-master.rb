# # Cookbook Name:: cdh3
# Recipe:: hbase-master
#
# Copyright 2011, Space Rock Duck Velociraptor
#
# All rights reserved - Do Not Redistribute
#
include_recipe 'cdh3::default'

package 'hadoop-hbase-master'

zk_peers = search(:node, 'role:zookeeper_peer').map {|peer| peer.ipaddress}
template '/etc/hbase/conf/hbase-site.xml' do
  source 'hbase-site.xml'
  owner 'hbase'
  group 'hadoop'
  mode 0744
  variables(:namenode => search(:node, 'role:name_node').first.hostname,
            :zk_peers => zk_peers)
end

cookbook_file '/etc/hbase/conf/hbase-env.sh' do
  source 'hbase-env.sh'
  owner 'hbase'
  group 'hadoop'
  mode 0755
end

service 'hadoop-hbase-master' do
  supports :status => true, :start => true, :stop => true, :restart => true
  action [:enable, :start]
end
