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
apt-get install -y openjdk-7-jdk
cd /opt
wget -q http://apache.mirrors.pair.com/zookeeper/zookeeper-3.4.6/zookeeper-3.4.6.tar.gz
tar -xzf zookeeper-3.4.6.tar.gz

MYID=$1
mkdir -p /var/zookeeper/{data,conf}
echo -n $MYID > /var/zookeeper/data/myid
cat > /var/zookeeper/conf/zoo.cfg <<EOF
tickTime=2000
initLimit=10
syncLimit=5
dataDir=/var/zookeeper/data
clientPort=2181
server.1=192.168.12.11:2888:3888
server.2=192.168.12.12:2888:3888
server.3=192.168.12.13:2888:3888
EOF

cat > /etc/init/zookeeper.conf <<EOF
exec /opt/zookeeper-3.4.6/bin/zkServer.sh start-foreground /var/zookeeper/conf/zoo.cfg
EOF
start zookeeper
