name 'travis_sbt_extras'
maintainer 'Gilles Cornu'
maintainer_email 'foss@gilles.cornu.name'
license 'Apache 2.0'
description 'Installs sbt-extras to ease the building of scala projects'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.3.0'

depends 'travis_java'

conflicts 'typesafe-stack' # See http://community.opscode.com/cookbooks/typesafe-stack
conflicts 'chef-sbt' # See http://community.opscode.com/cookbooks/chef-sbt

depends 'debian'
depends 'ubuntu'
depends 'centos'
depends 'redhat'
depends 'fedora'
depends 'scientific'
depends 'suse'
depends 'amazon'
depends 'freebsd'
depends 'mac_os_x'

recipe 'travis_sbt_extras::default', 'Downloads and installs sbt-extras script'