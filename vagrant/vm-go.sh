#!/usr/bin/env bash

cp /etc/apt/sources.list /etc/apt/sources.list.old
cat > /etc/apt/sources.list <<EOF
deb http://mirrors.163.com/ubuntu/ precise main restricted universe multiverse
deb http://mirrors.163.com/ubuntu/ precise-security main restricted universe multiverse
deb http://mirrors.163.com/ubuntu/ precise-updates main restricted universe multiverse
deb http://mirrors.163.com/ubuntu/ precise-proposed main restricted universe multiverse
deb http://mirrors.163.com/ubuntu/ precise-backports main restricted universe multiverse
deb-src http://mirrors.163.com/ubuntu/ precise main restricted universe multiverse
deb-src http://mirrors.163.com/ubuntu/ precise-security main restricted universe multiverse
deb-src http://mirrors.163.com/ubuntu/ precise-updates main restricted universe multiverse
deb-src http://mirrors.163.com/ubuntu/ precise-proposed main restricted universe multiverse
deb-src http://mirrors.163.com/ubuntu/ precise-backports main restricted universe multiverse
EOF

apt-get update
apt-get install -y build-essential git-core mercurial curl
#cd /opt
#hg clone -u release https://code.google.com/p/go
#cd go/src
#./all.bash

apt-get install -y python-software-properties  # 12.04
add-apt-repository ppa:duh/golang
apt-get update
apt-get install -y golang  # go1.1

# install gvm
# apt-get install curl bison
#bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)
#echo [[ -s "$HOME/.gvm/scripts/gvm" ]] && source "$HOME/.gvm/scripts/gvm" >> ~/.profile

mkdir /home/vagrant/Go
cat > /home/vagrant/.profile <<EOF
export GOPATH=\$HOME\Go
export PATH=\$HOME/bin:/opt/go/bin:\$PATH
export ZOOKEEPER_SERVERS=192.168.12.11:2181,192.168.12.12:2181,192.168.12.13:2181
EOF
chown vagrant:vagrant /home/vagrant/.profile

sudo -u vagrant -i go get github.com/samuel/go-zookeeper/zk
sudo -u vagrant -i go get github.com/mmcgrana/zk

# 创建一个连接到主机
#ln -s /vagrant/zk src/zk
