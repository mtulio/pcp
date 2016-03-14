class profile::mcollective::client {

  $mcollective_broker_host = hiera('profiles::mcollective::broker_host')
  $mcollective_broker_port = hiera('profiles::mcollective::broker_port')
  $mcollective_broker_user = hiera('profiles::mcollective::broker_user')
  $mcollective_broker_password = hiera('profiles::mcollective::broker_password')
  $mcollective_mco_loglevel = hiera('profiles::mcollective::mco_loglevel')

  class { '::mcollective::client':
    activemq_pool_host     => $mcollective_broker_host,
    activemq_pool_port     => $mcollective_broker_port,
    activemq_pool_user     => $mcollective_broker_user,
    activemq_pool_password => $mcollective_broker_password,
    mco_loglevel           => $mcollective_mco_loglevel,
  }
}
