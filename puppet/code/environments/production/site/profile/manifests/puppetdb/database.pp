class profile::puppetdb::database {

  $postgres_version = hiera('profiles::puppetdb::postgres_version')
  $postgres_package_version = hiera('profiles::puppetdb::postgres_package_version')

  $puppetdb_pg_name = hiera('profiles::puppetdb::pgconf::name')
  $puppetdb_pg_user = hiera('profiles::puppetdb::pgconf::user')
  $puppetdb_pg_pass = hiera('profiles::puppetdb::pgconf::pass')
  $puppetdb_pg_host = hiera('profiles::puppetdb::pgconf::host')

  class { 'postgresql::globals':
    encoding            => 'UTF-8',
    locale              => 'en_US.UTF-8',
    version             => $postgres_version,
    manage_package_repo => true,
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

  postgresql::server::db { $puppetdb_pg_name:
    user     => $puppetdb_pg_user,
    password => postgresql_password($puppetdb_pg_user, $puppetdb_pg_pass)
  }

  postgresql::server::pg_hba_rule {'access for the puppetdb service':
    type        => 'host',
    database    => $puppetdb_pg_name,
    user        => $puppetdb_pg_user,
    auth_method => 'md5',
    address     => $puppetdb_pg_host,
  }
}
