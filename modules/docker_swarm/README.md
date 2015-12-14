# Docker Swarm

[![Build Status](https://travis-ci.org/scotty-c/puppet-docker_swarm.svg?branch=master)](https://travis-ci.org/scotty-c/puppet-docker_swarm)

#### Table of Contents

1. [Overview](#overview)
2. [Module Description](#module-description)
3. [Usage](#usage)
4. [Dependencies](#dependencies) 
5. [Development](#development)

## Overview

A module to install aand configure Docker Swarm.

## Module Description

This module installs Docker Swarm from source, The module has the option to configure Docker and Golang for you. (Note it takes about 5 mins for the first puppet run as it compiles both swarm and golang)
The module has support for all the back ends that Docker Swarm supports (consul, etcd, mesos or zookepper) or you can create a native swarm cluster
This is the first release of the module so if there are any feature request please log them in the issue page. I will try to get to as many as possible.


The module is compatible with :

RHEL 6 family

RHEL 7 family

Ubuntu 12.04

Ubuntu 14.04


## Usage
For basic usage:
```
include docker_swarm
```
To customize the install with a third party back end:
```
class {'docker_swarm':}

swarm_cluster {'cluster 1':
  ensure       => present,
  backend      => 'consul',
  cluster_type => 'join',
  port         => '8500',
  address      => '172.17.8.101',
  path         => 'swarm'
  } 
```
The provider allows the following types

````backend```` this can be consul, etcd, mesos or zookepper


`````cluster_type````` this can be either join, manage or swarm


````port```` this the port for connection to the backend. For example consul would be 8500

 
````address```` this is the address of the backend


````path```` this is the path for the key/value store


To customize the install using the native swarm discovery service:
```
class {'docker_swarm':}

swarm_cluster {'cluster 1':
  ensure       => present,
  backend      => 'swarm',
  cluster_type => 'create',
  } 
```

To manage the the cluster with a third party back end:
```
class {'docker_swarm':}

swarm_cluster {'cluster 1':
  ensure       => present,
  backend      => 'consul',
  cluster_type => 'manage',
  port         => '8500',
  address      => '172.17.8.101',
  path         => 'swarm', 
  } 
```

##Dependencies 

This module needs : 

[`scottyc/golang`](https://github.com/scotty-c/puppet-golang)

[`garethr/docker`](https://github.com/garethr/garethr-docker)

[`puppetlabs/stdlib`](https://github.com/puppetlabs/puppetlabs-stdlib)

[`puppetlabs/vcsrepo`](https://github.com/puppetlabs/puppetlabs-vcsrepo)

## Demo Lab

If you want to test Docker Swarm I built a 4 node lab for the Sydney Puppet user group. You can find that here


[`Swarm Demo Lab`](https://github.com/scotty-c/puppet-meetup)


## Development

Pull request welcome. Just hit me up.

## Next Release
Support for running swarm exec commands and Docker-compose integration