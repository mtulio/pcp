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

Usando esse Vagrantfile, subir o Puppet se torna uma tarefa simples e rápida.

## Tecnologias

* Puppet Server 2.1.2
* PuppetDB 3.2.4
* Puppet Agent 1.4.1
* PostgreSQL 9.4.6
* Puppet Explorer 2.0.0
* ActiveMQ 5.9

Todo ambiente é instalado e configurado via Puppet 4.

## Autores

* Guto Carvalho (gutocarvalho@gmail.com)
* Miguel Di Ciurcio Filho (miguel.filho@gmail.com)

## Contribuidores

* Adriano Vieira
* Lauro Silveira

## Compatibilidade

Este projeto foi testado com vagrant boxes CentOS 7

## Requisitos

* Virtualbox >= 4
* Vagrant >= 1.8
  * plugin vagrant-hostsupdater (atua no host)
  * plugin vagrant-hosts (atua no guest)
  * plugin vagrant-proxyconf (caso necessite e esteja atrás de proxy)
* Box gutocarvalho/centos7x64

Você precisa ter pelo menos 2 GB de RAM livre para subir as VMs.

## Setup

    vagrant plugin install vagrant-hosts
    vagrant plugin install vagrant-hostsupdater
    vagrant box add gutocarvalho/centos7x64
    git clone https://github.com/gutocarvalho/pcp.git
    cd pcp
    vagrant up

### Proxy Setup

Para o caso de estar atrás de um serviço proxy:

1. instale o plugin para proxy

  ```
  vagrant plugin install vagrant-proxyconf
  ```

2. altere as configurações no ```Vagrantfile``` (linhas 11 e 12) de acordo com o seu serviço de proxy

  ```
  config.proxy.http     = "http://10.122.19.54:5865"
  config.proxy.https    = "http://10.122.19.54:5865"
  ```

## Ambiente

Existem 3 VMs no ambiente

* puppetserver.hacklab, 192.168.250.20
* puppetdb.hacklab, 192.168.250.25
* puppetmq.hacklab, 192.168.250.30

### ambiente::puppetserver

Nesta VM será instalado o puppet server 2.1.2, puppet agent 1.4.1.

### ambiente::puppetdb

Nesta VM será instalado o puppetdb 3.2.4, postgresql 9.4.6, puppet agent 1.4.1.

### ambiente::puppetmq

Nesta VM será instalado o activemq 5.9 e puppet agent 1.4.1.

## Uso

### uso::puppetserver

acessando a vm

    vagrant ssh puppetserver

### uso::puppetdb

acessando a vm

    vagrant ssh puppetdb

### uso::puppetmq

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

Acesse o puppet explorer através da URL

    https://puppetdb.hacklab

Aceite o certificado, se possível use firefox ou chrome.

Rode o agente algumas vezes em cada nó para visualizar mais informações no dashboard.
