# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  # configura proxy se necessário e o plugin estiver instalado
  if Vagrant.has_plugin?("vagrant-proxyconf")
    #vagrant plugin install vagrant-proxyconf (check https://tmatilai.github.io/vagrant-proxyconf/)
    config.proxy.http     = "http://10.122.19.54:5865"
    config.proxy.https    = "http://10.122.19.54:5865"
    config.proxy.no_proxy = "localhost, 127.0.0.1, .hacklab"
  end

  # box para todas as VM
  config.vm.box = "gutocarvalho/centos7x64"

  # puppet server + puppet agent
  config.vm.define "puppetserver" do |puppetserver|
    puppetserver.vm.hostname = "puppetserver.hacklab"
    puppetserver.vm.network :private_network, ip: "192.168.250.20"
    puppetserver.vm.provision "shell", path: "puppet/instala.sh"
    puppetserver.vm.provision :hosts do |provisioner|
      provisioner.autoconfigure = true
      provisioner.sync_hosts = true
    end
    puppetserver.vm.provider "virtualbox" do |v|
      v.customize [ "modifyvm", :id, "--cpus", "2" ]
      v.customize [ "modifyvm", :id, "--memory", "1024" ]
    end
  end

  # puppet agent + puppetdb + puppet explorer
  config.vm.define "puppetdb" do |puppetdb|
    puppetdb.vm.hostname = "puppetdb.hacklab"
    puppetdb.vm.network :private_network, ip: "192.168.250.25"
    puppetdb.vm.provider "virtualbox" do |v|
      v.customize [ "modifyvm", :id, "--cpus", "2" ]
      v.customize [ "modifyvm", :id, "--memory", "512" ]
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
    puppetmq.vm.network :private_network, ip: "192.168.250.30"
    puppetmq.vm.provider "virtualbox" do |v|
      v.customize [ "modifyvm", :id, "--cpus", "2" ]
      v.customize [ "modifyvm", :id, "--memory", "512" ]
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
