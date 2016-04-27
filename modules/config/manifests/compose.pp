class config::compose {
  
if $hostname =~ /^swarm-master*/ {
 
 notice ["This server is the Swarm Manager."]

}

else {

file { '/root/docker-compose.yml':
  ensure  => file,
  content => template("config/registrator.yml.erb"), 
  } ->

docker_compose {'swarm app':
  ensure => present, 
  source => '/root',  
  scale => ['1']
    }
  }
}