class config::compose {

if $hostname =~ /^swarm-master*/ {

 notice ["This server is the Swarm Manager."]

}

else {

class {'docker::compose':} ->

file { '/root/docker-compose.yml':
  ensure  => file,
  content => template("config/registrator.yml.erb"),
  } ->

docker_compose {'/root/docker-compose.yml':
  ensure => present,
    }
  }
}
