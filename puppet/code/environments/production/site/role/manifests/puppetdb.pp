class role::puppetdb {

  include profile::puppet::agent
  include profile::mcollective::server
  include profile::puppetdb::database
  include profile::puppetdb::app
  include profile::puppetdb::frontend

}
