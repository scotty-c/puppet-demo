# == Class: config
#
#
class config(
  
  $consul_ip = "$::ipaddress_enp0s8", 

){
  
  include config::consul_config 
  contain config::swarm
  contain config::compose
  contain config::dns
  contain config::run_containers

  Class['config::swarm'] -> Class['config::compose'] -> Class['config::dns'] -> Class['config::run_containers']
}


