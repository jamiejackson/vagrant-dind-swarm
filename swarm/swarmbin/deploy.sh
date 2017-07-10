#!/bin/bash
set -x

docker stack deploy --compose-file=docker-compose.simple_swarm.yml db
