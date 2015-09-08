#!/bin/bash

docker kill mysql; docker rm mysql
docker kill mongo; docker rm mongo
docker kill redis; docker rm redis
docker kill wifi_server; docker rm wifi_server

