#!/bin/bash

# limpando diretorios
rm -rf /etc/puppetlabs/code
rm -rf /etc/puppetlabs/puppet/ssl

# sincronizando diretorio code
rsync -av /vagrant/puppet/code /etc/puppetlabs/

# instala modulos forge
puppet module install puppetlabs/apache -v 1.7.1
puppet module install puppetlabs/vcsrepo
puppet module install puppetlabs/puppetdb
puppet module install puppetlabs/postgresql
puppet module install puppetlabs/stdlib
puppet module install puppetlabs/concat
puppet module install puppetlabs/firewall
puppet module install puppetlabs/java
puppet module install puppetlabs/java_ks
puppet module install spotify/puppetexplorer
puppet module install hunner/hiera

# instala modulos instruct
cd /etc/puppetlabs/code/environments/production/modules
git clone https://bitbucket.org/instruct/puppet-activemq.git activemq
git clone https://bitbucket.org/instruct/puppet-mcollective.git mcollective
git clone https://bitbucket.org/instruct/puppet-puppet puppet
git clone https://bitbucket.org/instruct/puppet-developer.git puppet_developer

# chama puppet
puppet apply /etc/puppetlabs/code/environments/production/manifests/site.pp
