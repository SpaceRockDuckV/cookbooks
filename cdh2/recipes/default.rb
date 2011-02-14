#
# Cookbook Name:: cdh2
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
