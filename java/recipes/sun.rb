#
# Cookbook Name:: java
# Recipe:: sun
#
# Copyright 2010, Opscode, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

node.run_state[:java_pkgs] = value_for_platform(
  ["debian","ubuntu"] => {
    "default" => ["sun-java6-jre","default-jre-headless"]
  },
  "default" => ["sun-java6-jre"]
)

case node.platform
when "debian","ubuntu"
  include_recipe "apt"
 
  template "/etc/apt/sources.list.d/canonical.com.list" do
    mode "0644"
    source "canonical.com.list.erb"
    notifies :run, "execute[apt-get update]", :immediately
  end
when "centos"
    execute "retrieve the jdk" do
        # this url might need to be refreshed.  get a link from the jdk download site
        command 'wget -O /tmp/sun-jdk.rpm.bin "http://cds.sun.com/is-bin/INTERSHOP.enfinity/WFS/CDS-CDS_Developer-Site/en_US/-/USD/VerifyItem-Start/jdk-6u23-linux-i586-rpm.bin?BundledLineItemUUID=.mmJ_hCvQTEAAAEuPMEpGyD7&OrderID=RrSJ_hCv_ncAAAEuMMEpGyD7&ProductID=QhOJ_hCw.dUAAAEsFIMcKluK&FileName=/jdk-6u23-linux-i586-rpm.bin"'
        creates "/tmp/sun-jdk.rpm.bin"
        umask 022
        user 'chef'
    end

    execute "chmod a+x /tmp/sun-jdk.rpm.bin" do
        action :run
    end

    execute "install the jdk" do
        # the jdk installer needs to run in it's own shell
        # echo ^M to bypass the prompts
        command %q{sh -c "yes '^M' | sudo /tmp/sun-jdk.rpm.bin"}
        not_if "test -d /usr/java/"
    end

    template "/etc/profile.d/java.sh" do
        source "java.sh"
        mode 0755
    end
else
  Chef::Log.error("Installation of Sun Java packages are only supported on Debian/Ubuntu/CentOS at this time.")
end
