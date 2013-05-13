#
# Cookbook Name:: varscoper
# Recipe:: default
#
# Copyright 2012, Nathan Mische
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
#

# Install the unzip package
package "unzip" do
  action :install
end

file_name = node['varscoper']['download']['url'].split('/').last

node.set['varscoper']['owner'] = node['cf10']['installer']['runtimeuser'] if node['varscoper']['owner'] == nil

# Download varscoper
remote_file "#{Chef::Config['file_cache_path']}/#{file_name}" do
  source "#{node['varscoper']['download']['url']}"
  action :create_if_missing
  mode "0744"
  owner "root"
  group "root"
  not_if { File.directory?("#{Chef::Config['file_cache_path']}/#{file_name}") }
end

# Create the target install directory if it doesn't exist
directory "#{node['varscoper']['install_path']}" do
  owner node['varscoper']['owner']
  group node['varscoper']['group']
  mode "0755"
  recursive true
  action :create
  not_if { File.directory?("#{node['varscoper']['install_path']}") }
end

# Extract archive
script "install_varscoper" do
  interpreter "bash"
  user "root"
  cwd "#{Chef::Config['file_cache_path']}"
  code <<-EOH
unzip #{file_name}
mv varscoper-master #{node['varscoper']['install_path']}/varscoper4
chown -R #{node['varscoper']['owner']}:#{node['varscoper']['group']} #{node['varscoper']['install_path']}/varscoper4
EOH
  not_if { File.directory?("#{node['varscoper']['install_path']}/varscoper4") }
end

coldfusion10_config "extensions" do
  action :set
  property "mapping"
  args ({ "mapName" => "/varscoper4",
          "mapPath" => "#{node['varscoper']['install_path']}/varscoper4" })
end

# Create a global apache alias if desired
template "#{node['apache']['dir']}/conf.d/global-varscoper-alias" do
  source "global-varscoper-alias.erb"
  owner node['apache']['user']
  group node['apache']['group']
  mode "0755"
  variables(
    :url_path => '/varscoper',
    :file_path => "#{node['varscoper']['install_path']}/varscoper"
  )
  only_if { node['varscoper']['create_apache_alias'] }
  notifies :restart, "service[apache2]"
end

# Clean Up
file "#{Chef::Config['file_cache_path']}/#{file_name}" do
  action :delete
end

directory "#{node['varscoper']['install_path']}/varscoper-master" do
  recursive true
  action :delete
end

directory "#{Chef::Config['file_cache_path']}/varscoper-master" do
  recursive true
  action :delete
end