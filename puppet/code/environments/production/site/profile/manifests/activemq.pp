class profile::activemq {

  $activemq_mco_password = hiera('profiles::activemq::mco_password')

  yumrepo { 'puppetlabs-deps':
    ensure   => 'present',
    baseurl  => 'http://yum.puppetlabs.com/el/7/dependencies/$basearch',
    descr    => 'Puppet Labs Dependencies El 7 - $basearch',
    enabled  => '1',
    gpgcheck => '1',
  }

  class  { 'java':
    distribution => 'jdk',
    version      => 'latest',
  }

  class { '::activemq':
    mco_password => $activemq_mco_password,
  }

}
