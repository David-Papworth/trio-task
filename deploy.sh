#!/bin/bash

# Create network
docker network create trio-task-network

# Build images
docker build -t trio-db db
docker build -t trio-flask-app flask-app

# Run database container
docker run -d --network trio-task-network --name mysql trio-db

# Run Flask app
docker run -d --network trio-task-network --name flask-app trio-flask-app

# Run NGINX container
docker run -d -p 80:80 --network trio-task-network --name nginx --mount type=bind,source=$(pwd)/nginx/nginx.conf,target=/etc/nginx/nginx.conf nginx:alpine

docker ps -a