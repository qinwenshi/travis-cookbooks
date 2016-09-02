unless node['travis_go_worker']['docker']['disable_install']
  include_recipe 'travis_docker'
end

template '/etc/default/docker.chef' do
  source 'etc-default-docker.chef.sh.erb'
  owner 'root'
  group 'root'
  mode 0o644
end

template '/etc/default/docker' do
  source 'etc-default-docker.sh.erb'
  owner 'root'
  group 'root'
  mode 0o644
end

template '/etc/init/docker.conf' do
  source 'etc-init-docker.conf.erb'
  owner 'root'
  group 'root'
  mode 0o644
end

template '/etc/init/travis-worker.conf' do
  source 'etc-init-travis-worker.conf.erb'
  owner 'root'
  group 'root'
  mode 0o644
  variables(docker_image: node['travis_go_worker']['docker_image'])

  not_if do
    node['travis_go_worker']['docker_image'].to_s.empty?
  end
end

service 'travis-worker' do
  action [:enable, :start]
end
