# Adverator Vagrant

## Structure

Folder structure

```
adverator
↳ www
↳ ops
↳ vagrant
```

Setup

```
mkdir adverator
cd adverator
```

Adverator public site

```
git clone git@github.com:reconstrukt/adverator.git www
```

Adverator OPS (optional)

```
git clone git@github.com:reconstrukt/adverator-ops.git ops
```

If you not need/want ops, just make an empty directory

```
mkdir ops
```

Vagrant

```
git clone git@github.com:nathanwinther/addy-vagrant.git vagrant
```

## Vagrant

Vagrant

```
vagrant up
```

Host

```
192.168.33.10 dev.adverator.com devops.adverator.com
```

## Node/Gulp

```
vagrant ssh
cd /var/www/html/www
npm install --save-dev .
gulp
```

## MySQL

From host

```
mysql -h127.0.0.1 -P6612 -uvagrant -pvagrant adverator
```

From guest

```
mysql -uroot adverator
```

