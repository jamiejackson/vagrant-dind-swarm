This isn't a full-fledged project. I'm just trying to get inter-container communication working in a Docker-in-Docker swarm running on Vagrant.

I'm creating a repo so I might get some help with my problem.

https://forums.docker.com/t/docker-swarm-docker-in-docker-container-communication/34425/2

# Prerequisites

* [Vagrant](https://www.vagrantup.com/downloads.html)
* [VirtualBox](https://www.virtualbox.org/wiki/Downloads) (Vagrant can install VirtualBox if it's not already on your system.)

# Working with Vagrant

From the clone directory, issue:

`vagrant up`

To SSH into the machine:

`vagrant ssh`

For the following commands, change to the shared vagrant directory:

`cd /vagrant/`

# Working with the Cluster/Stack

## start up local swarm cluster

```
swarmbin/start_swarm.sh
```

## visualize swarm

* http://192.168.56.111:8081/

## deploy stack

```
swarmbin/deploy.sh
```

## watch slave's logs

This shows whether communication is failing, or not.

```
docker service logs --follow db_slave
```

## undeploy stack

```
swarmbin/undeploy.sh
```

## kill swarm

```
swarmbin/kill_swarm.sh
```