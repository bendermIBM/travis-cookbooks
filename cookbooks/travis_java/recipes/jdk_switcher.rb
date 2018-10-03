directory ::File.dirname(node['travis_java']['jdk_switcher_path']) do
  owner 'root'
  group 'root'
  mode 0o755
  recursive true
end

remote_file node['travis_java']['jdk_switcher_path'] do
  source node['travis_java']['jdk_switcher_url']
  owner node['travis_build_environment']['user']
  group node['travis_build_environment']['group']
  mode 0o644
end


if node['kernel']['machine'] == 'ppc64le'
  ruby_block "Edit jdk_switcher" do
    block do
      require 'chef/util/file_edit'
      nc = Chef::Util::FileEdit.new(node['travis_java']['jdk_switcher_path'])
      nc.insert_line_after_match(/ARCH_SUFFIX=amd64/, "elif uname -a | grep ppc64le >/dev/null; then \n   ARCH_SUFFIX=ppc64el")
      nc.write_file
    end
    not_if { ::File.readlines(node['travis_java']['jdk_switcher_path']).grep(/ppc64el/).any? }
  end
end

if node['kernel']['machine'] == 's390x'
  ruby_block "Edit jdk_switcher" do
    block do
      require 'chef/util/file_edit'
      nc = Chef::Util::FileEdit.new(node['travis_java']['jdk_switcher_path'])
      nc.insert_line_after_match(/ARCH_SUFFIX=amd64/, "elif uname -a | grep s390x >/dev/null; then \n   ARCH_SUFFIX=s390x")
      nc.write_file
    end
    not_if { ::File.readlines(node['travis_java']['jdk_switcher_path']).grep(/s390x/).any? }
  end
end