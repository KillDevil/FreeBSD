#!/bin/bash

#docker run -p 27017:27017 --name ws_mongo_inst_001 -v ~/data/mongo/db:/data/db -d mongo
docker run --name redis -d redis
docker run --name mongo -d mongo
docker run --name mysql -e MYSQL_ROOT_PASSWORD=123456 -d -p 3306:3306 mysql
docker run -d -p 80:80 --name wifi_server --link redis:redis_db --link mongo:mongo_db --link mysql:mysql_db -v ~/data/www:/data/workdir leozvc/docker-php-yaf
