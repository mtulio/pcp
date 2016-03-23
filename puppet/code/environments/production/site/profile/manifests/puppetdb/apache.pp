class profile::puppetdb::apache {

  class { 'apache':
    default_vhost => false,
  }

  $vhost_name = hiera('profiles::puppetdb::puppetdb_server_hostname')
  apache::vhost { "${vhost_name}_default":
    servername => $vhost_name,
    port     => '80',
    docroot  => '/var/www/html',
    priority => '05',
    rewrites => [
        {
          comment      => '# This will enable the Rewrite to HTTPS',
          rewrite_cond => ['%{HTTPS} !=on'],
          rewrite_rule => ['^/?(.*) https://%{SERVER_NAME}/$1 [R,L]'],
        },
      ],
  }

}
