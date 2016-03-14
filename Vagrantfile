# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  # puppet server + puppet agent
  config.vm.define "puppetserver" do |puppetserver|
    puppetserver.vm.hostname = "puppetserver.hacklab"
    puppetserver.vm.box = "gutocarvalho/centos7x64"
    puppetserver.vm.network :private_network, ip: "192.168.250.20"
    puppetserver.vm.provision "shell", path: "puppet/instala.sh"
    puppetserver.vm.provision :hosts do |provisioner|
      provisioner.autoconfigure = true
      provisioner.sync_hosts = true
    end
    puppetserver.vm.provider "virtualbox" do |v|
      v.customize [ "modifyvm", :id, "--cpus", "2" ]
      v.customize [ "modifyvm", :id, "--memory", "2048" ]
    end
  end

  # puppet agent + puppetdb + puppet explorer
  config.vm.define "puppetdb" do |puppetdb|
    puppetdb.vm.hostname = "puppetdb.hacklab"
    puppetdb.vm.box = "gutocarvalh/centos7x64"
    puppetdb.vm.network :private_network, ip: "192.168.250.25"
    puppetdb.vm.provider "virtualbox" do |v|
      v.customize [ "modifyvm", :id, "--cpus", "2" ]
      v.customize [ "modifyvm", :id, "--memory", "1024" ]
    end
    puppetdb.vm.provision :hosts do |provisioner|
      provisioner.autoconfigure = true
      provisioner.sync_hosts = true
      provisioner.add_host '192.168.250.20', ['puppet']
    end
    puppetdb.vm.provision "puppet_server" do |puppet|
      puppet.puppet_server = "puppetserver.hacklab"
      puppet.puppet_node = "puppetdb.hacklab"
      puppet.options = "--verbose"
    end
  end

  #  puppet agent + mcollective client + activemq
  config.vm.define "puppetmq" do |puppetmq|
    puppetmq.vm.hostname = "puppetmq.hacklab"
    puppetmq.vm.box = "gutocarvalho/centos7x64"
    puppetmq.vm.network :private_network, ip: "192.168.250.30"
    puppetmq.vm.provider "virtualbox" do |v|
      v.customize [ "modifyvm", :id, "--cpus", "2" ]
      v.customize [ "modifyvm", :id, "--memory", "1024" ]
    end
    puppetmq.vm.provision :hosts do |provisioner|
      provisioner.autoconfigure = true
      provisioner.sync_hosts = true
      provisioner.add_host '192.168.250.20', ['puppet']
    end
    puppetmq.vm.provision "puppet_server" do |puppet|
      puppet.puppet_server = "puppetserver.hacklab"
      puppet.puppet_node = "puppetmq.hacklab"
      puppet.options = "--verbose"
    end
  end

end
