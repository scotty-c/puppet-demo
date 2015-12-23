class config::run_containers {

 if $hostname =~ /swarm-master-01/ {
  
   swarm_run {'jenkins-1':
   ensure  => present,
   image   => 'jenkins',
   ports   => ['8080:8080'],
   require => Class['config::swarm'] 
    }
  
   swarm_run {'nginx-1':
   ensure  => present,
   image   => 'nginx',
   ports   => ['80:80', '443:443'],
   require => Class['config::swarm'] 
    }  
  }
}