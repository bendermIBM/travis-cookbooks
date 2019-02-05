# frozen_string_literal: true

# Cookbook Name:: travis_system_info
# Recipe:: default
#
# Copyright 2017 Travis CI GmbH
#
# MIT License
#

local_gem = "#{Chef::Config[:file_cache_path]}/system-info.gem"

remote_file local_gem do
  source node['travis_system_info']['gem_url']
  checksum node['travis_system_info']['gem_sha256sum']
end

gem_executable_path = nil
gem_bin_path = nil

# s390x workaround to use default ruby instead of embedded chef gem
if node['kernel']['machine'] == 's390x'
  ruby_base_path = "#{node['travis_build_environment']['home']}/.rvm"
  gem_executable_path = "#{ruby_base_path}/rubies/ruby-#{node['travis_build_environment']['default_ruby']}/bin/gem"
  gem_bin_path = "#{ruby_base_path}/gems/ruby-#{node['travis_build_environment']['default_ruby']}/bin"
else
  gem_executable_path = "/opt/chef/embedded/bin/gem"
  gem_bin_path = "/opt/chef/embedded/bin/"
end

execute "#{gem_executable_path} install -b #{local_gem.inspect}"

execute "rm -rf #{node['travis_system_info']['dest_dir']}"

directory node['travis_system_info']['dest_dir'] do
  owner node['travis_build_environment']['user']
  group node['travis_build_environment']['group']
  recursive true
end

# if node['kernel']['machine'] == 's390x'

  # execute 'generate system-info report' do
  #   command
  # end
  # directory "/opt/chef/embedded/bin" do
  #   owner node['travis_build_environment']['user']
  #   group node['travis_build_environment']['group']
  #   recursive true
  # end

  # link "/opt/chef/embedded/bin/system-info" do
  #   to "#{gem_bin_path}/system-info"
  #   owner node['travis_build_environment']['user']
  #   group node['travis_build_environment']['group']
  # end

# else
ruby_block 'generate system-info report' do
  block do
    exec = Chef::Resource::Execute.new("#{gem_bin_path}/system-info report", run_context)
    exec.command(
      SystemInfoMethods.system_info_command(
        user: node['travis_build_environment']['user'],
        dest_dir: node['travis_system_info']['dest_dir'],
        commands_file: node['travis_system_info']['commands_file'],
        cookbooks_sha: node['travis_system_info']['cookbooks_sha']
      )
    )
    exec.environment('HOME' => node['travis_build_environment']['home'])
    exec.run_action(:run)
  end

  action :nothing
end

log 'system-info is coming for you' do
  notifies :run, 'ruby_block[generate system-info report]', :delayed
end




