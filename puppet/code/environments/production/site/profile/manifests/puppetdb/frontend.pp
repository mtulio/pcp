class profile::puppetdb::frontend  {

  $puppetexplorer_version = hiera('profiles::puppetexplorer::version')

  class { 'puppetexplorer':
    package_ensure => $puppetexplorer_version,
    vhost_options  => {
      'priority' => '05'
    },
  }

}
