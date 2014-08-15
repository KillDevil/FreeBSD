FROM ubuntu:14.10

MAINTAINER Yan Feng <t34@qq.com>

RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
RUN apt-get update

RUN apt-get install -y inotify-tools nginx apache2 openssh-server
