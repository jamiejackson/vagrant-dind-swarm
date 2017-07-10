#!/bin/bash

set -x

# https://codefresh.io/blog/deploy-docker-compose-v3-swarm-mode-cluster/

# vars
[ -z "$NUM_WORKERS" ] && NUM_WORKERS=3

# init swarm (need for service command); if not created
docker node ls 2> /dev/null | grep "Leader"
if [ $? -ne 0 ]; then
  if [ -d /vagrant ]; then
    # vagrant environment
    # eth0 worked
    # eth1 didn't work
    docker swarm init --advertise-addr=eth0 # --listen-addr=0.0.0.0 #  10.0.2.15
  else
    docker swarm init
  fi
fi

# get join token
SWARM_TOKEN=$(docker swarm join-token -q worker)

# get Swarm master IP (Docker for Mac xhyve VM IP)
export SWARM_MASTER=$(docker info --format "{{.Swarm.NodeAddr}}")
echo "Swarm master IP: ${SWARM_MASTER}"
sleep 10

# start Docker registry mirror
docker run -d --restart=always -p 4000:5000 --name v2_mirror \
  -v registry_mirror:/var/lib/registry \
  -e REGISTRY_PROXY_REMOTEURL=https://registry-1.docker.io \
  registry:2.5

# start Docker private registry (for pushing works-in-progress locally and
#  having them be available in swarm nodes.)
docker run -d --restart=always -p 4001:5000 --name private_registry \
  -v private_registry_data:/var/lib/registry \
  registry:2.5

# run NUM_WORKERS workers with SWARM_TOKEN
for i in $(seq "${NUM_WORKERS}"); do
  # remove node from cluster if exists
  docker node rm --force $(docker node ls --filter "name=worker-${i}" -q) > /dev/null 2>&1
  # remove worker contianer with same name if exists
  docker rm --force $(docker ps -q --filter "name=worker-${i}") > /dev/null 2>&1
  # run new worker container
  docker run -d --privileged --name worker-${i} --hostname=worker-${i} \
    -p ${i}2375:2375 \
    docker:stable-dind --registry-mirror http://${SWARM_MASTER}:4000 \
    --insecure-registry ${SWARM_MASTER}:4001
  sleep 1
  # add worker container to the cluster
  docker --host=localhost:${i}2375 swarm join --token ${SWARM_TOKEN} ${SWARM_MASTER}:2377
done

# show swarm cluster
printf "\nLocal Swarm Cluster\n===================\n"

docker node ls

# echo swarm visualizer
printf "\nLocal Swarm Visualizer\n===================\n"
docker run --rm -it -d --name swarm_visualizer \
  -p 8081:8080 -e HOST=localhost \
  -v /var/run/docker.sock:/var/run/docker.sock \
  dockersamples/visualizer