Description
===========

Installs the Varscoper tool.

Attributes
==========

* `node['varscoper']['install_path']` (Default is /vagrant/wwwroot)
* `node['varscoper']['owner']` (Default is `nil` which will result in owner being set to `node['cf10']['installer']['runtimeuser']`)
* `node['varscoper']['group']` (Default is bin)
* `node['varscoper']['download']['url']` (Default is https://github.com/mschierberl/varscoper/archive/master.zip)
* `node['varscoper']['create_apache_alias']` (Default is false)

Usage
=====

On ColdFusion server nodes:

    include_recipe "varscoper"