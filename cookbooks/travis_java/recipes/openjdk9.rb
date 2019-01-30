if node['lsb']['codename'] == 'xenial' && node['kernel']['machine'] == 'ppc64le'
  package %w[icedtea-8-plugin openjdk-9-jdk]
elsif node['lsb']['codename'] == 'xenial' && node['kernel']['machine'] == 's390x'
  package %w[icedtea-8-plugin openjdk-9-jdk]
else
  include_recipe 'travis_java::openjdk-r'
  package 'openjdk-9-jdk'
end
