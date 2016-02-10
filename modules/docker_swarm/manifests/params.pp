class docker_swarm::params {

  $install_docker   = true
  $install_golang   = true
  $go_version       = 'go1.5.3'
  $bind             = 'tcp://0.0.0.0:2375'
  $swarmroot        = '$GOPATH/bin:/usr/local/go/bin:$PATH'
  $base_dir         = '/usr/local/go/src/github.com'
  $backend          = ''
  $backend_ip       = ''
  $backend_port     = ''
  $advertise_int    = ''
  $swarm_dir        = '/usr/local/go/src/github.com/docker/swarm'
  $swarm_version    = 'v1.1.0'
}