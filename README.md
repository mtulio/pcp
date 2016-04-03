q# PCP - Puppet Configuration Platform

PCP project provides an completely Puppet 4x Platform installed and configured to be used as you want (labs, tests and modules development)!

## Table of Contents
* [Overview](#overview)
* [Description](#Description)
* [Technologies](#Technologies)
* [Compatibility](#Compatibility)
* [Requirement](#Requirement)
* [Environment](#Environment)
 * [Virtual Machines](#Virtual-Machines)
 * [Structure](#Structure)
* [Setup](#Setup)
 * [Vagrant requirements](#vagrant-requirements)
 * [Initial configuration](#initial-configuration)
* [Usage](#usage)
 * [Puppet Server](#puppet-server)
 * [Puppet Explorer](#puppetdb)
 * [Mcollective](#activemq)
* [License](#license)
* [Development](#development)
* [Credits](#credits)
 * [Author](#authors)
 * [Contributors](#contributors)


## Overview

PCP project offers a completely Puppet environment that you can use, for example, in your labs to puppet modules tests and development.

## Description

PCP automated the completely installation of Puppet Environment on version 4. The installation will create three virtual machines using Vagrant.

Using this Vagrant configuration file (Vagrantfile) the tasks to setup up a complete  Puppet Environment will be fast and easy!

Try it and contribute with us!

## Technology

The following technologies is used:
* Puppet Server 2.1.2
* PuppetDB 3.2.4
* Puppet Agent 1.4.1
* PostgreSQL 9.4.6
* Puppet Explorer 2.0.0
* ActiveMQ 5.9

NOTE: All the environment is installed and configured using Puppet version 4.

## Compatibility

This project was tested with vagrant boxes on CentOS 7.

## Requirement

NOTE: you shall have at least 2GB RAM free to setup up all the environment.

* Virtualbox >= 4
* Vagrant >= 1.8
* plugin: vagrant-hostsupdater (runs on host)
* plugin: vagrant-hosts (runs on guest)
* plugin: vagrant-proxyconf (if you are behind a proxy)
* Vagrant box: gutocarvalho/centos7x64

You must install and setup [Vagrant](https://www.vagrantup.com/docs/installation/) with [Virtual Box](https://www.virtualbox.org/wiki/Downloads) provider. You can see more information [here](https://www.vagrantup.com/docs/virtualbox/).

## Environment

### Virtual Machines

The environment is composed basically with three virtual machines:

* puppetserver: puppetserver.hacklab (192.168.250.20)
* puppetdb: puppetdb.hacklab (192.168.250.25)
* puppetmq: puppetmq.hacklab (192.168.250.30)

#### puppetserver

This VM have installed the Puppet Server 2.1.3 and Puppet Agent 1.4.1.

#### puppetdb (Puppet Explorer)

This VM have installed Puppetdb 3.2.4, postgresql 9.4.6 and Puppet Agent 1.4.1.

#### puppetmq (Mcollective)

This VM have installed the ActiveMQ 5.9 and Puppet Agent 1.4.1

### Structure

This project uses a repository [pcp-controlrepo](https://github.com/gutocarvalho/pcp-controlrepo) with sources for r10k. r10k will install the 'production environment' that will be used by puppet to configure the VMs.

Check out this repo available at [https://github.com/gutocarvalho/pcp-controlrepo](https://github.com/gutocarvalho/pcp-controlrepo) to see all modules available on a 'production' environment.

## SETUP

### Vagrant requirements

Install vagrant dependencies:
```
[1] $ vagrant plugin install vagrant-hosts
[2] $ vagrant plugin install vagrant-hostsupdater
[3] $ vagrant box add gutocarvalho/centos7x64
```
NOTE:
* If you have find some errors on step [3] like 'HTTP server doesn't seem to support byte ranges. Cannot resume', try to continue download with option '-c':

```shell
vagrant box add -c gutocarvalho/centos7x64
```

#### Proxy Setup

If you are behind an proxy or want to use it configuration, you follow these steps

1. Install a proxy plugin

```shell
vagrant plugin install vagrant-proxyconf
```

2. Change the proxy parameters on ```Vagrantfile``` (lines 11 and 12) according your  condoguration:

```shell
config.proxy.http = "http://10.122.19.54:5865"
config.proxy.https = "http://10.122.19.54:5865"
```

### Initial Configuration

```shell
[1] $ git clone https://github.com/gutocarvalho/pcp.git
[2] $ cd pcp
[3] $ vagrant up
```

## Usage

### puppetserver

Access Puppet Server VM using SSH:
```shell
vagrant ssh puppetserver
```

### puppetdb

Access Puppet Explorer VM using SSH:
```shell
vagrant ssh puppetdb
```

Access the puppet explorer using URL https://puppetdb.hacklab and accept the certificate as a trusted. Puppet Explorer works better on browsers Firefox or Chrome.

You can see more information on dashboard when you run the puppet agent a few times.


### puppetmq

Access Mcollective VM using SSH:
```shell
vagrant ssh puppetmq
```

The Mcollective client was installed on VM puppetmq.hacklab, you can access the VM using ssh and test it with find command:

```shell
vagrant ssh puppetmq.hacklab
sudo -i mco find
```

## License

This project is under [Apache 2.0](#LICENSE) license.

## Development

You're very welcome to contribute with this project, before please take a look at these pages:
* [Contributing page](#CONTRIBUTING.md)
* [README page](#README)
* [Issues page](https://github.com/gutocarvalho/pcp/issues)

## Credits
### Authors
* Guto Carvalho (gutocarvalho@gmail.com)
* Miguel Di Ciurcio Filho (miguel.filho@gmail.com)

### Contributors
* Adriano Vieira
* Lauro Silveira
* Marco Tulio R Braga (https://github.com/mtulio)
