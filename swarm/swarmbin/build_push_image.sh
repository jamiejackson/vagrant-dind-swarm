#!/bin/bash
set -x

docker build -t localhost:4001/jamiejackson/mariadb-replication:10.2 ./10.2
docker push localhost:4001/jamiejackson/mariadb-replication:10.2