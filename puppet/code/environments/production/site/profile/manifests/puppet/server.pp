class profile::puppet::server {

  $agent_version = hiera('profiles::puppet::agent::agent_version')
  $puppetmaster = hiera('profiles::puppet::agent::puppetmaster')
  $puppetmaster_autosign = hiera('profiles::puppet::master::autosign')
  $server_version = hiera('profiles::puppet::master::server_version')
  $puppetdb_server = hiera('profiles::puppet::master::puppetdb_server')
  $puppetdb_version = hiera('profiles::puppet::master::puppetdb_version')

  $jruby_instances = $::processorcount * 2

  $server_java_opts = "-Xms512m -Xmx512m"

  # Bug relacionado: https://tickets.puppetlabs.com/browse/SERVER-557
  file {'/etc/systemd/system/puppetserver.service.d':
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
  }

  file {'/etc/systemd/system/puppetserver.service.d/local.conf':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => "[Service]\nTimeoutStartSec=300\n",
  }

  class {'::puppet':
    server                      => true,
    server_ca_enabled           => true,
    autosign                    => $puppetmaster_autosign,
    runmode                     => 'service',
    server_java_opts            => $server_java_opts,
    server_version              => $server_version,
    agent_version               => $agent_version,
    puppetmaster                => $puppetmaster,
    puppetdb                    => true,
    puppetdb_server             => $puppetdb_server,
    puppetdb_version            => $puppetdb_version,
    server_reports              => ['log', 'puppetdb'],
    server_max_active_instances => $jruby_instances,
  }

}
