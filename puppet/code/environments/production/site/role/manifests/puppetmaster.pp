class role::puppetmaster {

  include profile::puppet::server
  include profile::puppet::hiera
  include profile::mcollective::server

}
