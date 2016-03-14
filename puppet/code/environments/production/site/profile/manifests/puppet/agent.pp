class profile::puppet::agent {

  $agent_version = hiera('profiles::puppet::agent::agent_version')
  $puppetmaster = hiera('profiles::puppet::agent::puppetmaster')

  class {'puppet':
    runmode       => 'service',
    certname      => $::trusted['certname'],
    agent_version => $agent_version,
    puppetmaster  => $puppetmaster,
  }

}
