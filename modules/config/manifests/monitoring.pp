class config::monitoring {

if $hostname =~ /^master*/ {
  
  consul::service { 'swarm-master-01':
    checks  => [
      {
      script   => 'docker -H tcp://172.17.8.114:4000 info',
      interval => '10s',
      tags     => ['swarm-master-01']
      }
    ],
    address => $::ipaddress_enp0s8,
     }  
   
  consul::service { 'swarm-master-02':
    checks  => [
      {
      script   => 'docker -H tcp://172.17.8.115:4000 info',
      interval => '10s',
      tags     => ['swarm-master-02']
      }
    ],
    address => $::ipaddress_enp0s8,
     }  
   }

}