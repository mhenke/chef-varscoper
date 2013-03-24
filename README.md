Description
===========

Installs the Cloudly With A Chance of Tests for ColdFusion.

Attributes
==========

* `node['cloudy']['install_path']` (Default is /vagrant/wwwroot)
* `node['cloudy']['owner']` (Default is `nil` which will result in owner being set to `node['cf10']['installer']['runtimeuser']`)
* `node['cloudy']['group']` (Default is bin)
* `node['cloudy']['download']['url']` (Default is https://github.com/mhenke/Cloudy-With-A-Chance-Of-Tests/archive/develop.zip)
* `node['cloudy']['create_apache_alias']` (Default is false)

Usage
=====

On ColdFusion server nodes:

    include_recipe "cloudy"