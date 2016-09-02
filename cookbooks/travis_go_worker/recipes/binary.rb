remote_file '/usr/local/bin/travis-worker' do
  source ::File.join(
    'https://travis-worker-artifacts.s3.amazonaws.com',
    'travis-ci/worker',
    node['travis_go_worker']['branch'].to_s,
    'build/linux/amd64/travis-worker'
  )
  owner 'root'
  group 'root'
  mode 0o755

  not_if { node['travis_go_worker']['branch'].to_s.empty? }
end

include_recipe 'travis_go_worker::config'
