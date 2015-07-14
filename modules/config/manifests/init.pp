# == Class: config
#
#
class config(
  
 $consul_ip = "$::ipaddress_enp0s8", 
 ){
  
  include config::consul_config 
   
  class {'config::swarm':} ->
  class {'config::compose':}
}


