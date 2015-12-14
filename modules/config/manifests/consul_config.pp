class config::consul_config {

if $hostname =~ /^*101*$/ {

  class { 'consul':
    config_hash => {
      'datacenter'       => 'dev',
      'data_dir'         => '/opt/consul',
      'ui_dir'           => '/opt/consul/ui',
      'bind_addr'        => $::ipaddress_enp0s8,
      'client_addr'      => '0.0.0.0',
      'node_name'        => "$::hostname",
      'advertise_addr'   => '172.17.8.101',
      'bootstrap_expect' => '1',
      'server'           => true
       }
     }
  }  
 
else {

 class { 'consul':
  config_hash => {
      'bootstrap'      => false,
      'datacenter'     => 'dev',
      'data_dir'       => '/opt/consul',
      'ui_dir'         => '/opt/consul/ui',
      'bind_addr'      => $::ipaddress_enp0s8,
      'client_addr'    => '0.0.0.0',
      'node_name'      => "$::hostname",
      'advertise_addr' => $::ipaddress_enp0s8,
      'start_join'     => ['172.17.8.101','172.17.8.103','172.17.8.103'],
      'server'         => false
      }
    }
  } 

  ::consul::service { 'docker-service':
  checks  => [
    {
    script   => 'service docker status',
    interval => '10s',
    tags     => ['docker-service']
    }
  ],
  address => $::ipaddress_enp0s8,
  }
}