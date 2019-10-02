# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.network "private_network", ip: "192.168.33.10"
  config.vm.network "forwarded_port", guest: 3306, host: 6612

  config.vm.synced_folder "../www", "/var/www/html/www"
  config.vm.synced_folder "../ops", "/var/www/html/ops"

  config.vm.provider "virtualbox" do |vb|
    vb.name = "Adverator"
    vb.cpus = 2
    vb.memory = "2048"
  end
  
  config.vm.provision "shell", path: "provision.sh"
end
