#!/usr/bin/ruby env

require "socket"
$hostname = Socket.gethostname

forge 'http://forge.puppetlabs.com'


mod 'puppetlabs/stdlib'
mod 'puppetlabs/vcsrepo'
mod 'puppet/archive', :git => 'https://github.com/voxpupuli/puppet-archive.git'
mod 'nanliu/staging'
mod 'KyleAnderson/consul', '1.0.5'
mod 'scottyc/docker_swarm'
mod 'scottyc/golang'
mod 'garethr/docker', :git => 'https://github.com/garethr/garethr-docker.git'
mod 'stankevich/python'
mod 'stahnma/epel'
mod 'maestrodev/wget'

