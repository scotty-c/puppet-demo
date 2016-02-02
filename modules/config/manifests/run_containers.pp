class config::run_containers {

 if $hostname =~ /swarm-master-02/ {
  
   swarm_run {'jenkins-1':
   ensure  => present,
   image   => 'jenkins',
   ports   => ['8080:8080'],
   volume  => '/root/jenkins:/var/jenkins_home',
   require => Class['config::swarm'] 
    }
  
   swarm_run {'nginx-1':
   ensure     => present,
   image      => 'nginx',
   ports      => ['80:80', '443:443'],
   log_driver => 'syslog',
   network    => 'swarm-private',
   require    => Class['config::swarm'] 
    }  
  
   swarm_run {'redis-1':
   ensure  => present,
   image   => 'redis',
   network => 'swarm-private',
   require => Class['config::swarm'] 
    }
  }
}