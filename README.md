This isn't a full-fledged project. I'm just trying to get inter-container communication working in a Docker-in-Docker swarm running on Vagrant.

The goal is to get the `db_slave` service to be able to access the `db_master` on port 3306. (This works in Docker for Mac, but I can't get it working in Vagrant.)

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

# Working with the Cluster/Stack

For the following commands, be sure that you're in an SSH session in the Vagrant VM (see above), then change to the shared vagrant directory:

`cd /vagrant/swarm`

## start up local swarm cluster

```
# change the interface to try another; omit the option to use the default.
swarmbin/start_swarm.sh --advertise-addr=eth0 
```

## visualize swarm

* http://192.168.56.111:8081/

## deploy stack

```
swarmbin/deploy.sh
```

## test - watch slave's logs

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