# -*- mode: ruby -*-
# vi: set ft=ruby :
$script = <<SCRIPT

sudo service apache2 stop 

sudo apt-get install libyaml-dev
sudo apt-get install -y git-core

sudo apt-get install -y python python-dev python-pip
python --version 
pip -V
sudo pip install -U pip virtualenv

SCRIPT

Vagrant.configure(2) do |config|
  config.vm.define "atmo-api" do |vm2|
    vm2.vm.box = "ubuntu/trusty64"
    vm2.vm.network "private_network", ip: "192.168.72.19"
# don't believe I need this to get Atmosphere API going...
#    vm2.vm.network "forwarded_port", guest: 80, host: 9650
    vm2.vm.provision "shell", inline: $script, privileged: false
    vm2.vm.provider "virtualbox" do |v2|
      v2.memory = 4096
      v2.cpus = 4
    end
  end
end