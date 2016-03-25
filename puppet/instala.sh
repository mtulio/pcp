#!/bin/bash

CONTROL_REPO="https://github.com/gutocarvalho/pcp-controlrepo.git"

# limpando diretorios
rm -rf /etc/puppetlabs/code/*
rm -rf /etc/puppetlabs/puppet/ssl

# definindo locale
export LC_ALL='en_US.UTF-8'

# apagando certificados
rm -rf /etc/puppetlabs/puppet/ssl

# instalando r10k
/opt/puppetlabs/puppet/bin/gem install --no-ri --no-rdoc r10k

# configurando hieradata
cat > /etc/puppetlabs/code/hiera.yaml <<EOF
---
:backends:
  - yaml
:hierarchy:
  - "nodes/%{::trusted.certname}"
  - "%{::operatingsystem}-%{::operatingsystemmajrelease}"
  - "%{::osfamily}-%{::operatingsystemmajrelease}"
  - "%{::osfamily}"
  - common

:yaml:
# - /etc/puppetlabs/code/environments/%{environment}/hieradata on *nix
# - %CommonAppData%\PuppetLabs\code\environments\%{environment}\hieradata on Windows
# When specifying a datadir, make sure the directory exists.
  :datadir:
EOF

# configurando r10k
mkdir -p /etc/puppetlabs/r10k
cat > /etc/puppetlabs/r10k/r10k.yaml <<EOF
---
:cachedir: /opt/puppetlabs/server/data/puppetserver/r10k
:sources:
  puppet:
    basedir: /etc/puppetlabs/code/environments
    remote: $CONTROL_REPO
EOF

# deploy do environment
/opt/puppetlabs/puppet/bin/r10k deploy environment production -v debug --puppetfile

# chama o puppet
puppet apply /etc/puppetlabs/code/environments/production/manifests/site.pp
