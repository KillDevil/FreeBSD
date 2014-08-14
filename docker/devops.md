## Vagrant 抽象虚拟机

- site: http://www.vagrantup.com/
- repo: http://www.vagrantbox.es/

### Vagrant 用途

- 简化多虚拟机管理
- 打造开发环境
- 中心仓库 + 版本控制

```
	# 从远程拉取一个已有的虚拟机
    vagrant box add "https://s3.amazonaws.com/itmat-public/centos-6.3-chef-10.14.2.box"
    # 启动主机
    vagrant up
    # 登陆主机
    vagrant ssh
```

## CoreOS  云服务器

- site: https://coreos.com/
- coreos for vagrant

### CoreOS 物性

- 只读的 /root + docker
- 双 /root 链式更新
- 轻量

```
git clone https://github.com/coreos/coreos-vagrant.git
cd coreos-vagrant
echo "$update_channel='stable'" > config.rb
# 启动 coreos
vagrant up
# 打印 docker 命令
# docker
```

## Docker 容器管理

- site: https://docker.io
- repo: https://registry.hub.docker.com/
- dockerfile: https://github.com/dockerfile?tab=repositories
- into: http://www.csdn.net/article/2014-08-08/2820312-Docker-lxc-paas-virtualization
- tags: container dockerfile git-commit image 

![construct](http://tech.uc.cn/wp-content/uploads/2014/04/docker-filesystems-multilayer.png)

### Doucker: Image

- readonly 
- run as container

### Doucker: Container

- instance of image
- writeable 
- build as image

### Docker: Usage

- 拉取共公的 base iamge
```
docker pull ubuntu # centos:7.0 
```

> `centos:7.0` 叫 tag, 和 vcs 一样

运行容器
```
docker run -it ubuntu 
# docker help run 列出 run 命令的选项
# -name <string>  可以给创建的容器命名
```

### Devops pipeline

```
# local
docker pull ubuntu centos
docker images
# ubuntu centos:7.0
```

#### 创建程序托管环境
1. 直接在运行中的容器里操作

2. 使用 dockerfile 
```dockerfile
FROM ubuntu
RUN \
	apt-get update
	apt-get install -y java scala clojure node 
```

构建新的IMAGE
```
docker build --rm -t zchxlab:appbase .
# –rm 可以删除回逆历史, 因为 RUN 会产生新 container, 层层叠加
```

将IMAGE发到远程服务器

```
scp  appbase to cloude server#1
```

#### 创建服务器环境

```dockerfile
FROM ubuntu
RUN \ 
    apt-get update
    apt-get install -y nginx postgresql redis

# CMD 的参数可以被 `docker run`的参数覆盖, ENTRYPOINT 的不可以
CMD nginx /etc/config/nginx.conf
ENTRYPOINT \
    ["postgresql" "-port" "82"]
    ["redis-server" "-port" "81"]
```

构建IMAGE并分发到远程服务器执行
```
# local/构建IMAGE
docker build --rm -t zchxlab:serverbase .	
# local/复制IMAGE到远程
scp . to cloude server#2
# remote/运行容器
docker run --name memcache_service -d dev:memcache -p 80:80 -p 81:81  -p 82:82
# remote/传说公司有大数据, 直接拉取公共容器
docker pull sequenceiq/hadoop-docker
docker run -i -t sequenceiq/hadoop-docker /etc/bootstrap.sh -bash # -d 能让容器在后台运行
```

查看IMAGE历史
```
$ docker history redis:2.8.12
IMAGE               CREATED             CREATED BY                                      SIZE
93b82aa81b58        12 days ago         /bin/sh -c #(nop) CMD [redis-server]            0 B
c94970038951        12 days ago         /bin/sh -c #(nop) EXPOSE map[6379/tcp:{}]       0 B
62171f9fa97c        12 days ago         /bin/sh -c #(nop) USER redis                    0 B
9749c281646b        12 days ago         /bin/sh -c #(nop) WORKDIR /data                 0 B
db8f75f1b2d2        12 days ago         /bin/sh -c #(nop) VOLUME /data                  0 B
62e6a72ee1c8        12 days ago         /bin/sh -c mkdir /data && chown redis:redis /   0 B
2c751d2d058f        12 days ago         /bin/sh -c make -C /usr/src/redis install       8.434 MB
e186fa68d574        12 days ago         /bin/sh -c make -C /usr/src/redis test || tru   283.6 kB
59848959fef0        12 days ago         /bin/sh -c make -C /usr/src/redis               40.94 MB
b8cc9f4a635d        12 days ago         /bin/sh -c #(nop) ADD dir:115410786c1bf2e8c22   14.72 MB
c48940f9fc45        10 weeks ago        /bin/sh -c apt-get update && apt-get install    626.1 MB
842b5a724d2d        10 weeks ago        /bin/sh -c groupadd -r redis && useradd -r -g   328.4 kB
f106b5d7508a        10 weeks ago        /bin/sh -c #(nop) CMD [/bin/bash]               0 B
1e8abad02296        10 weeks ago        /bin/sh -c #(nop) ADD file:bf31c4f934dcaac38e   121.8 MB
511136ea3c5a        14 months ago                                                       0 B
```

删除IMAGE
```
$ docker rmi ubuntu:test_image
Untagged: ubuntu:test_image
Deleted: c864d4646f3a649314a9b5da5286ced67cf1d73bc1a9b3a92a542b1b3bc69741
```

###创建私有的Docker仓库

启动仓库服务器进程
```
docker run -p 5000:5000 registry
```

上传IMAGE到仓库
```
docker tag ubuntu:14.10 localhost:5000/yf
docker push localhost:5000/yf
```

拉取IMAGE
```
docker pull localhost:5000/yf
```