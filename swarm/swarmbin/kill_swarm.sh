#!/bin/bash
set -x

docker swarm leave --force
docker stop worker-{1,2,3,4}
docker rm worker-{1,2,3,4}
