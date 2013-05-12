#
# Cookbook Name:: varscoper
# Recipe:: default
#
# Copyright 2012, Mike Henke
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

file_name = 'varscoper4.zip'

node.set['varscoper']['owner'] = node['cf10']['installer']['runtimeuser'] if node['varscoper']['owner'] == nil

# Download varscoper
remote_file "#{Chef::Config['file_cache_path']}/#{file_name}" do
  source "#{node['varscoper']['download']['url']}"
  action :create_if_missing
  mode "0744"
  owner "root"
  group "root"
  not_if { File.directory?("#{node['varscoper']['install_path']}/varscoper4") }
end