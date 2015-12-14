# The private class that looks after the swarm install

class docker_swarm::install {


file { [$docker_swarm::base_dir, "${docker_swarm::base_dir}/docker"]:
  ensure  => directory,
  recurse => true,
  } ->

vcsrepo { $docker_swarm::swarm_dir:
  ensure   => present,
  provider => git,
  source   => 'https://github.com/docker/swarm.git',
  revision => $docker_swarm::swarm_version,
  require  => File[$docker_swarm::base_dir]
  } ->

exec { 'build swarm':
  cwd       => $docker_swarm::swarm_dir,
  command   => "bash -l -c 'go get github.com/tools/godep && godep go install .'",
  path      => '/usr/local/go/bin/:/usr/bin:/bin:',
  creates   => '/usr/local/go/bin/swarm',
  timeout   => 600 , #This is for slower machines or vagrant testing
  logoutput => on_failure,
  }

file { 'symlink swarm':
  ensure  => link,
  path    => '/usr/bin/swarm',
  target  => '/usr/local/go/bin/swarm',
  require => Exec['build swarm']
  }
}