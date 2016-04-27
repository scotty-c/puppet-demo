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

  consul::service { 'docker-service':
  checks  => [
    {
    script   => 'service docker status',
    interval => '10s',
    tags     => ['docker-service']
    }
  ],
  address => $::ipaddress_enp0s8,
  }

  
# if $hostname =~ /^swarm-master*/ {
#   consul::check { 'kibana':
#     ensure   =>  present, 
#     tcp      => 'kibana.service.consul:80', 
#     interval => '10s',
#     }

#   consul::check { 'logstash-5000':
#     ensure   =>  present, 
#     tcp      => 'logstash-5000.service.consul:5000', 
#     interval => '10s',
#     }  
  
#   consul::service { 'swarm-master-01':
#     checks  => [
#       {
#       script   => 'docker -H tcp://172.17.8.114:4000 info',
#       interval => '10s',
#       tags     => ['swarm-master-01']
#       }
#     ],
#     address => $::ipaddress_enp0s8,
#      }  
   
#   consul::service { 'swarm-master-02':
#     checks  => [
#       {
#       script   => 'docker -H tcp://172.17.8.115:4000 info',
#       interval => '10s',
#       tags     => ['swarm-master-02']
#       }
#     ],
#     address => $::ipaddress_enp0s8,
#      }  
#    }
 }     