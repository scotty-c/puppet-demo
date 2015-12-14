
# A module for Docker swarm 

class docker_swarm(

  $install_docker  = $docker_swarm::params::install_docker,
  $install_golang  = $docker_swarm::params::install_golang,
  $go_version      = $docker_swarm::params::version,
  $go_package      = $docker_swarm::params::go_package, 
  $bind            = $docker_swarm::params::bind,
  $swarmroot       = $docker_swarm::params::swarmroot,
  $base_dir        = $docker_swarm::params::base_dir,
  $backend         = $docker_swarm::params::backend,
  $backend_ip      = $docker_swarm::params::backend_ip,
  $backend_port    = $docker_swarm::params::backend_port,
  $advertise_int   = $docker_swarm::params::advertise_int,
  $swarm_dir       = $docker_swarm::params::swarm_dir,
  $swarm_version   = $docker_swarm::params::swarm_version,
  

) inherits docker_swarm::params {
  validate_re($::osfamily, '^(Debian|RedHat)$', 'This module only works on Debian and Red Hat based systems.')
  validate_bool($install_docker)
  validate_bool($install_golang)

  if ! defined(Package['git']) {
    package { 'git':
      ensure => installed,
      before => Class['golang']
    }
  }

  if install_docker {
    class {'docker':
      tcp_bind => $bind,
      extra_parameters => "--cluster-store=${backend}://${backend_ip}:${backend_port} --cluster-advertise=${advertise_int}:2376"
      }
    
    Class['docker'] -> Class['docker_swarm::install']
  }
  
  if install_golang {
    case $::osfamily {
      'RedHat' : {
         class {'golang':
         from_source     => false,
         package_version => $go_package,
        }
      }
     'Debian' :{
        class {'golang':
         from_source => true,
         version => $go_version,
        }
      }
    }    
  
  Class['golang'] -> Class['docker_swarm::install']
  
  }

  class {'docker_swarm::install':}
}

