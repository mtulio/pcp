class role::puppetmaster {

  include profile::puppet::hiera
  include profile::puppet::server
  include profile::mcollective::server

}
