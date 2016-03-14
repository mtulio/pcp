# PCP
## [P]uppet [C]ommunity [P]latform

#### Tabela de conteudo

1. [Overview](#overview)
2. [Tecnologias](#tecnologias)
3. [Autores](#autores)
4. [Contribuidores](#contribuidores)
5. [Compatibilidade](#compatibilidade)
6. [Requisitos](#requisitos)
7. [Setup](#setup)
8. [Ambiente](#ambiente)
9. [Estrutura](#estrutura)
10. [Mcollective](#mcollective)
11. [PuppetExplorer](#puppetexplorer)
12. [Debian8](#debian8)

## Overview

O projeto PCP tem o objetivo de oferecer um ambiente virtual Puppet completo para testes e desenvolvimento de módulos Puppet.

## Tecnologias

* Puppet Server 2.1.2
* PuppetDB 3.2.4
* Puppet Agent 1.3.5
* PostgreSQL 9.4.6
* Puppet Explorer 2.0.0
* ActiveMQ 5.9

Todo ambiente é instalado e configurado via Puppet 4.

## Autores

Guto Carvalho (gutocarvalho@gmail.com)
Miguel Di Ciurcio Filho (miguel.filho@gmail.com)

## Contribuidores

Seja um contribuidor, envie seu PR.

## Compatibilidade

Este projeto foi testado com boxes CentOS 7.

## Requisitos

* Virtualbox >= 4
* Vagrant >= 1.8
  * plugin vagrant-hostsupdater (atua no host)
  * plugin vagrant-hosts (atua no guest)
* Box gutocarvalho/centos7x64

Você precisa ter pelo menos 4 GB de RAM livre para subir as VMs.

## Setup

    vagrant plugin install vagrant-hosts
    vagrant plugin install vagrant-hostupdater
    vagrant box add gutocarvalho/centos7x64
    git clone https://github.com/gutocarvalho/puc.git
    cd puc
    vagrant up

## Ambiente

Existem 3 VMs no ambiente

* puppetserver.hacklab, 192.168.250.20
* puppetdb.hacklab, 192.168.250.25
* puppetmq.hacklab, 192.168.250.30

### puppetserver

Nesta VM será instalado o puppet server 2.1.2, puppet agent 1.3.5.

### puppetdb

Nesta VM será instalado o puppetdb 3.2.4, postgresql 9.4.6, puppet agent 1.3.5.

### puppetmq

Nesta VM será instalado o activemq 5.9 e puppet agent 1.3.5.

## Uso

### puppetserver

acessando a vm

    vagrant ssh puppetserver

### puppetdb

acessando a vm

    vagrant ssh puppetdb

### puppetmq

acessando a vm

    vagrant ssh puppetmq

## Estrutura

O diretório code da raiz contém a estrutura abaixo

```
- environments
- - production
- - - environment.conf
- - - hieradata
- - - - Debian-8.yaml
- - - - RedHat-7.yaml
- - - - common.yaml
- - - manifests
- - - - site.pp
- - - site
- - - - profile
- - - - - manifests
- - - - - - mcollective
- - - - - - - client.pp
- - - - - - - server.pp
- - - - - - puppet
- - - - - - - hiera.pp
- - - - - - - agent.pp
- - - - - - - server.pp
- - - - - - puppetdb
- - - - - - - app.pp
- - - - - - - database.pp
- - - - - - - frontend.pp
- - - - role
- - - - - manifests
- - - - - - broker.pp
- - - - - - puppetdb.pp
- - - - - - puppetmaster.pp
```

## Mcollective

O Mcollective client foi instalado na vm puppetmq.hacklab, você pode acessar a VM e testá-lo com o comando find.

    vagrant ssh puppetmq.hacklab
    sudo -i
    mco find

## PuppetExplorer

Se desejar ativar o puppet explorer, após rodar o setup pela primeira vez, edite o arquivo puppetdb.pp na vm puppetserver.hacklab e descomente a linha frontend.

    /etc/puppetlabs/code/environments/production/site/role/manifests/puppetdb.pp

Depois disto vá até a VM puppetdb.hacklab e chame o puppet agent duas vezes

    vagrant ssh puppetdb.hacklab
    sudo -i
    puppet agent -t
    puppet agent -t

Ingore o erro no final da primeira execução. Após a conclusão, abra seu navegador e acesse a url

    https://puppetdb.hacklab

Aceite o certificado, se possível use firefox ou chrome.

## Debian 8

Você pode utilizar a box gutocarvalho/debian8 na vm puppetserver e puppetdb se desejar.

Infelizmente na puppetmq não foi possível rodar o activeMQ em Debian 8, isto ocorre devido a versão muito antiga do pacote no repositório Debian.

A Puppet Labs empacota o ActiveMQ para EL mas ainda não o faz para Debian.
