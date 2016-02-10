class config::run_containers {

 if $hostname =~ /swarm-master-02/ {
  
   swarm_run {'jenkins':
   ensure  => present,
   image   => 'jenkins',
   ports   => '8080:8080',
   require => Class['config::swarm'] 
   }
  
   swarm_run {'nginx':
   ensure  => present,
   image   => 'nginx',
   ports   => '80:80',
   require => Class['config::swarm'] 
   }  
  
   swarm_run {'redis':
   ensure  => present,
   image   => 'redis',
   ports   => '6379:6379',
   require => Class['config::swarm'] 
   }  

  }
}