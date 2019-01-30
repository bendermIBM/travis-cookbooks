if node['kernel']['machine'] == 'ppc64le' && node['lsb']['codename'] == 'xenial'
  include_recipe 'travis_java::openjdk-r'
  package 'openjdk-7-jdk'
<<<<<<< HEAD
=======
elsif node['kernel']['machine'] == 's390x' && node['lsb']['codename'] == 'xenial'
  include_recipe 'travis_java::openjdk-r'
  package 'openjdk-7-jdk'
>>>>>>> 40a442d911637cbe2147d3e99a2fb86734a2025d
else
  package %w[
    icedtea-7-plugin
    openjdk-7-jdk
  ]
end
