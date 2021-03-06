
#
# PostGIS packages are available in Ubuntu main repository as of 14.04 (Trusty)
#
if node['lsb']['codename'] == 'precise'
  apt_repository 'ubuntugis-stable' do
    uri 'http://ppa.launchpad.net/ubuntugis/ppa/ubuntu'
    distribution node['lsb']['codename']
    components ['main']
    key '314DF160'
    keyserver 'hkp://ha.pool.sks-keyservers.net'
    retries 2
    retry_delay 30
    action :add
  end
end

#
# At the moment, the same PostGIS *single* version is installed for all PostgreSQL instances
#
([node['postgresql']['default_version']] + node['postgresql']['alternate_versions']).each do |pg_version|
  package "postgresql-#{pg_version}-postgis-#{node['postgresql']['postgis_version']}"
end
