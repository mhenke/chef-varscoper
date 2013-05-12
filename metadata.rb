name             "varscoper"
maintainer       "NATHAN MISCHE"
maintainer_email "henke.mike@gmail.com"
license          "Apache 2.0"
description      "Installs/Configures varscoper"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.1"

%w{ centos redhat ubuntu }.each do |os|
  supports os
end

depends "zip"

recipe "varscoper", "Installs varscoper"