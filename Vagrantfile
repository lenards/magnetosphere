# -*- mode: ruby -*-
# vi: set ft=ruby :
$script = <<SCRIPT

sudo service apache2 stop
sudo usermod -a -G www-data vagrant

# appears to be needed to avoid '404 Not Found' errors on
# some packages like `gcc/libstdc++-4.8-dev_4.8.4`
#
sudo apt-get update

sudo apt-get install libyaml-dev
sudo apt-get install -y git-core

sudo apt-get install -y python python-dev python-pip
python --version
pip -V
sudo pip install -U pip virtualenv

SCRIPT

Vagrant.configure(2) do |config|
  # NOTE: Use this if you find `npm install` is hanging
  # config.vm.provider :virtualbox do |vb|
  #   vb.customize ['modifyvm', :id, '--natdnshostresolver1', 'on']
  # end
  config.vm.define "atmosphere-dev" do |vm2|
    vm2.vm.box = "ubuntu/trusty64"
    vm2.vm.network "private_network", ip: "192.168.72.19"
    config.vm.synced_folder ".", "/vagrant",
        owner: "www-data", group: "www-data"
    vm2.vm.provision "shell", inline: $script, privileged: false
    vm2.vm.provider "virtualbox" do |v2|
      v2.memory = 4096*2
      v2.cpus = 2
    end
  end
end
