class config::compose {
  
if $hostname =~ /^swarm-master*/ {
 
 notice ["This server is the Swarm Manager."]

}

else {

 $erb = $::hostname ? {
  /.*101$/ => 'jenkins.yml',
  /.*102$/ => 'nginx.yml',
  /.*103$/ => 'rabbitmq.yml',
  }

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