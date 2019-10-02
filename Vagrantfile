# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.network "private_network", ip: "192.168.33.10"

  config.vm.synced_folder "../www", "/var/www/html/www"
  config.vm.synced_folder "../ops", "/var/www/html/ops"

  config.vm.provider "virtualbox" do |vb|
    vb.name = "Adverator"
    vb.cpus = 2
    vb.memory = "2048"
  end
  
  config.vm.provision "shell", inline: <<-SHELL
    sudo apt-get update -yq

    sudo apt-get install -y git

    # mysql blank root password
    echo "mysql-server mysql-server/root_password password \"''\"" | sudo debconf-set-selections
    echo "mysql-server mysql-server/root_password_again password \"''\"" | sudo debconf-set-selections

    # mysql
    export DEBIAN_FRONTEND="noninteractive"
    sudo -E apt-get install -yq mysql-server

    ln -sf /vagrant/mysql_adverator.conf /etc/mysql/conf.d/adverator.conf

    sudo service mysql restart

    # mysql create adverator database
    mysql -uroot --execute="CREATE DATABASE IF NOT EXISTS adverator DEFAULT CHARACTER SET = 'utf8';" mysql

    # php
    apt-get install -y php5-cli php5-fpm php5-curl php5-imap php5-mysql

    # php composer
    sudo php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
    sudo php composer-setup.php --install-dir=/usr/local/bin --filename=composer
    sudo php -r "unlink('composer-setup.php');"

    # node 6.x
    # https://github.com/nodesource/distributions/blob/master/README.md#debmanual
    curl -sSL https://deb.nodesource.com/gpgkey/nodesource.gpg.key | sudo apt-key add -

    VERSION=node_6.x
    DISTRO="$(lsb_release -s -c)"

    echo "deb https://deb.nodesource.com/$VERSION $DISTRO main" | sudo tee /etc/apt/sources.list.d/nodesource.list
    echo "deb-src https://deb.nodesource.com/$VERSION $DISTRO main" | sudo tee -a /etc/apt/sources.list.d/nodesource.list

    sudo apt-get update -yq
    sudo apt-get install -y nodejs

    sudo npm update -g
    sudo npm install gulp-cli -g

    # nginx
    sudo apt-get install -y nginx

    ln -sf /vagrant/nginx_adverator_www.conf /etc/nginx/sites-enabled/adverator_www.conf
    ln -sf /vagrant/nginx_adverator_ops.conf /etc/nginx/sites-enabled/adverator_ops.conf

    sudo service nginx restart

  SHELL
end
