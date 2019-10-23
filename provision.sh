#!/bin/sh

sudo apt-get update -yq

sudo apt-get install -y git sed g++

# mysql blank root password
echo "mysql-server mysql-server/root_password password \"''\"" | sudo debconf-set-selections
echo "mysql-server mysql-server/root_password_again password \"''\"" | sudo debconf-set-selections

# mysql
export DEBIAN_FRONTEND="noninteractive"
sudo -E apt-get install -yq mysql-server-5.6

sudo sed -i -e "s/^bind-address\s*=.*/bind-address = 0.0.0.0/g" /etc/mysql/my.cnf
sudo sed -i -e "s/^max_allowed_packet\s*=.*/max_allowed_packet = 256M/g" /etc/mysql/my.cnf

sudo service mysql restart

# mysql create vagrant user
mysql -uroot --execute="GRANT ALL PRIVILEGES ON *.* TO 'vagrant'@'%'; FLUSH PRIVILEGES; SET PASSWORD FOR 'vagrant'@'%' = PASSWORD('vagrant');" mysql

# mysql create adverator database
mysql -uroot --execute="CREATE DATABASE IF NOT EXISTS adverator DEFAULT CHARACTER SET = 'utf8';" mysql

# php
sudo apt-get install -y php5-cli php5-fpm php5-curl php5-imap php5-mysql

sudo sed -i -e "s/^short_open_tag\s*=.*/short_open_tag = On/g" /etc/php5/cli/php.ini
sudo sed -i -e "s/^short_open_tag\s*=.*/short_open_tag = On/g" /etc/php5/fpm/php.ini

sudo service php5-fpm restart

# php composer
sudo php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
sudo php composer-setup.php --install-dir=/usr/local/bin --filename=composer
sudo php -r "unlink('composer-setup.php');"

# node 6.x
# https://github.com/nodesource/distributions/blob/master/README.md#debmanual
curl -sSL https://deb.nodesource.com/gpgkey/nodesource.gpg.key | sudo apt-key add -

VERSION=node_10.x
DISTRO="$(lsb_release -s -c)"

echo "deb https://deb.nodesource.com/$VERSION $DISTRO main" | sudo tee /etc/apt/sources.list.d/nodesource.list
echo "deb-src https://deb.nodesource.com/$VERSION $DISTRO main" | sudo tee -a /etc/apt/sources.list.d/nodesource.list

sudo apt-get update -yq
sudo apt-get install -y nodejs

sudo npm update -g
sudo npm install gulp-cli -g

# nginx
sudo apt-get install -y nginx

sudo rm -f /etc/nginx/sites-enabled/default
sudo ln -sf /vagrant/nginx_adverator_www.conf /etc/nginx/sites-enabled/adverator_www.conf
sudo ln -sf /vagrant/nginx_adverator_ops.conf /etc/nginx/sites-enabled/adverator_ops.conf

sudo service nginx restart

# environment vars
sudo ln -sf /vagrant/profile_vagrant.sh /etc/profile.d/vagrant.sh

