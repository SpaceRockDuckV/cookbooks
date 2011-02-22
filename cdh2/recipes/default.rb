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


%w(mapred, hdfs, core).each do |conf|
    cookbook_file "/etc/hadoop/conf/#{conf}-site.xml" do
        source "#{conf}"
        owner "hadoop"
    end
end

%w(masters, slaves).each do |conf|
    template "/etc/hadoop/conf/#{conf}" do
        source "#{conf}"
        owner "hadoop"
    end
end

# dfs specific dirs
%w(name, data).each do |dir|
    directory "/usr/lib/hadoop/dfs/#{dir}" do
        owner "hadoop"
    end
end

# mapred specific dirs
%w(local, temp).each do |dir|
    directory "/usr/lib/hadoop/mapred/#{dir}" do
        owner "hadoop"
    end
end