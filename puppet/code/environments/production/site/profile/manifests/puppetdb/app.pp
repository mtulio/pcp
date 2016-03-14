class profile::puppetdb::app {

  $puppetdb_version = hiera('profiles::puppetdb::version')
  $database_hostname = hiera('profiles::puppetdb::database_hostname')
  $total_nodes = hiera('profiles::puppetdb::total_nodes', 10)
  $node_ttl = hiera('profiles::puppetdb::node_ttl', '90d')
  $report_ttl = hiera('profiles::puppetdb::report_ttl', '365d')
  $store_usage = hiera('profiles::puppetdb::store_usage', 10000)
  $temp_usage = hiera('profiles::puppetdb::temp_usage', 5000)
  $statements_cache_size = hiera('profiles::puppetdb::statements_cache_size', 0)

  validate_integer($total_nodes)
  validate_integer($statements_cache_size)

  #class {'puppetdb::globals':
  #  version => $puppetdb_version,
  #}

  # 1024MB plus 2MB per node
  $memory_jvm = 1024 + (2 * $total_nodes)

  $memory_reserved = floor($::memorysize_mb * 0.2)

  if $memory_reserved < 1024 {
    $memory_limit = floor($::memorysize_mb - $memory_reserved)
  } else {
    $memory_limit = $::memorysize_mb - 1024
  }

  #if $memory_jvm > $memory_limit {
  #  fail("Not enough memory for PuppetDB. Needs ${memory_jvm}MB and ${memory_limit}MB is available")
  #}

  #$java_args = { '-Xmx' => "${memory_jvm}m", '-Xms' => "${memory_jvm}m" }
  $java_args = { '-Xmx' => "512m", '-Xms' => "512m" }

  $command_threads = floor($::processorcount * 1.5)

  class { 'puppetdb::server':
    database_host          => $database_hostname,
    manage_firewall        => false,
    java_args              => $java_args,
    listen_address         => '0.0.0.0',
    command_threads        => $command_threads,
    node_ttl               => $node_ttl,
    report_ttl             => $report_ttl,
    store_usage            => $store_usage,
    temp_usage             => $temp_usage,
    database_validate      => false,
  }

  ini_setting { 'puppetdb_statements_cache_size':
    ensure  => present,
    path    => "${puppetdb::params::confdir}/database.ini",
    section => 'database',
    setting => 'statements-cache-size',
    value   => $statements_cache_size,
  }
}
