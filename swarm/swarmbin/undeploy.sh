#!/bin/bash
set -x
docker service rm db_{master,slave}