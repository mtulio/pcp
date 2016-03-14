class role::puppetdb {

  include profile::puppet::agent
  include profile::mcollective::server
  include profile::puppetdb::database
  include profile::puppetdb::app

  # caso deseje instalar o puppet explorer
  # descomente a linha abaixo
  # include profile::puppetdb::frontend

}
