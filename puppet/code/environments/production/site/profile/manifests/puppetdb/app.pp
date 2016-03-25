class profile::puppetdb::app {

  $puppetdb_version = hiera('profiles::puppetdb::version')

  $database_hostname = hiera('profiles::puppetdb::database_server_hostname')
  $database_username = hiera('profiles::puppetdb::pgconf::user')
  $database_password = hiera('profiles::puppetdb::pgconf::pass')

  $node_ttl = hiera('profiles::puppetdb::node_ttl', '90d')
  $report_ttl = hiera('profiles::puppetdb::report_ttl', '365d')
  $store_usage = hiera('profiles::puppetdb::store_usage', 10000)
  $temp_usage = hiera('profiles::puppetdb::temp_usage', 5000)
  $statements_cache_size = hiera('profiles::puppetdb::statements_cache_size', 0)
  $java_heap_mem = hiera('profiles::puppetdb::java_heap_mem','256')

  validate_integer($statements_cache_size)

  $java_args = { '-Xmx' => "${java_heap_mem}m", '-Xms' => "${java_heap_mem}m" }

  $command_threads = floor($::processorcount * 1.5)

  class { '::puppetdb::globals':
      version => $puppetdb_version,
  }

  class { '::puppetdb::server':
    database_host     => $database_hostname,
    database_username => $database_username,
    database_password => $database_password,
    manage_firewall   => false,
    java_args         => $java_args,
    listen_address    => '0.0.0.0',
    command_threads   => $command_threads,
    node_ttl          => $node_ttl,
    report_ttl        => $report_ttl,
    store_usage       => $store_usage,
    temp_usage        => $temp_usage,
    database_validate => false,
  }

  ini_setting { 'puppetdb_statements_cache_size':
    ensure  => present,
    path    => "${puppetdb::params::confdir}/database.ini",
    section => 'database',
    setting => 'statements-cache-size',
    value   => $statements_cache_size,
  }
}
