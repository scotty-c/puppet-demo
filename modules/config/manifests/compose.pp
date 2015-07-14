class config::compose {
  
if $hostname =~ /^*104*$/ {
 
 notice ["This server is the Swarm Manager."]

}

else {
 
  $ip = $::hostname ? {
  /.*101$/ => '10.0.1.10/24',
  /.*102$/ => '10.0.1.20/24',
  /.*103$/ => '10.0.1.30/24',
  }

 class { 'weave':
  peers => ['172.17.8.101','172.17.8.103','172.17.8.103'],
  expose    => $ip,
  client_ip => $::ipaddress_enp0s8,
  require   => Service['docker']
  }

 $erb = $::hostname ? {
  /.*101$/ => 'jenkins.yml',
  /.*102$/ => 'nginx.yml',
  /.*103$/ => 'rabbitmq.yml',
  }

docker::image { 'jenkins':} ->
docker::image { 'nginx':} ->
docker::image { 'gliderlabs/registrator':} ->
docker::image {'rabbitmq:3-management':} ->

file { '/root/docker-compose.yml':
  ensure  => file,
  content => template("config/$erb.erb"), 
  } ->

docker_compose {'swarm app':
  ensure => present, 
  source => '/root',  
  scale => ['1']
    }
  }
}