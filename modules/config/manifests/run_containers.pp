class config::run_containers {

 if $hostname =~ /swarm-master-02/ {
  
   swarm_run {'jenkins':
   ensure  => present,
   image   => 'jenkins',
   ports   => ['8080:8080'],
   #volume  => '/tmp/jenkins:/var/jenkins_home',
   require => Class['config::swarm'] 
   }
  
   swarm_run {'nginx':
   ensure     => present,
   image      => 'nginx',
   ports      => ['80:80'],
   log_driver => 'syslog',
   network    => 'swarm-private',
   require    => Class['config::swarm'] 
    }  
  
   swarm_run {'redis':
   ensure  => present,
   image   => 'redis',
   network => 'swarm-private',
   require => Class['config::swarm'] 
   }
  }
}