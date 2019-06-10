#!/usr/bin/env bash

docker build -t django:1 .
docker build -t postgres:1 db/

docker rm -f django_project postgres

NETWORK='my_network'

docker network rm $NETWORK

docker network create $NETWORK

docker run -d -it \
    --network $NETWORK \
    --name postgres \
    -h 0.0.0.0 \
    -e POSTGRES_PASSWORD='postgres' \
    -e POSTGRES_USER='postgres' \
    -e POSTGRES_DB='postgres' \
    postgres:1

docker run -it -p 8000:8000 \
    -e NAME='postgres' \
    -e USER='postgres' \
    -e PASSWORD='postgres' \
    -e PORT='5432' \
    --network $NETWORK \
    --name django_project \
    django:1

docker exec -it django_project python3 manage.py runserver 0.0.0.0:8000