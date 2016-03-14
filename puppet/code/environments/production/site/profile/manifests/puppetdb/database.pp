class profile::puppetdb::database {

  $puppetdb_server_hostname = hiera('profiles::puppetdb::puppetdb_server_hostname')
  $postgres_version = hiera('profiles::puppetdb::postgres_version')
  $postgres_package_version = hiera('profiles::puppetdb::postgres_package_version')

  include ::puppetdb::params

  class { 'postgresql::globals':
    encoding            => 'UTF-8',
    locale              => 'en_US.UTF-8',
    manage_package_repo => true,
    version             => $postgres_version,
  }

  class {'postgresql::server':
    listen_addresses => '*',
    package_ensure   => $postgres_package_version,
  }

  postgresql::server::config_entry {
    'checkpoint_segments':
      value => '32';
    'wal_keep_segments':
      value => '64'
  }

  postgresql::server::db {$::puppetdb::params::database_name:
    user     => $::puppetdb::params::database_username,
    password => postgresql_password($::puppetdb::params::database_username, $::puppetdb::params::database_password)
  }

  postgresql::server::pg_hba_rule {'access for the puppetdb service':
    type        => 'host',
    database    => $::puppetdb::params::database_name,
    user        => $::puppetdb::params::database_username,
    auth_method => 'md5',
    address     => $puppetdb_server_hostname,
  }
}
