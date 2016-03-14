class profile::puppet::hiera {

  class {'::hiera':
    hierarchy => [
      'nodes/%{::trusted.certname}',
      '%{::environment}',
      '%{::osfamily}',
      '%{::osfamily}-%{::operatingsystemmajrelease}',
      '%{::operatingsystem}-%{::operatingsystemmajrelease}',
      'common',
    ],
    datadir   => '/etc/puppetlabs/code/environments/%{::environment}/hieradata',
  }

}
