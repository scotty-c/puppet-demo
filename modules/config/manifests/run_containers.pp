class config::run_containers {

 if $hostname =~ /swarm-master-02/ {
  
  swarm_run {'logstash':
    ensure     => present,
    image      => 'scottyc/logstash',
    network    => 'swarm-private',
    ports      => ['9998:9998', '9999:9999/udp', '5000:5000', '5000:5000/udp'],
    env        => ['ES_HOST=elasticsearch', 'ES_PORT=9200'],
    command    => 'logstash -f /opt/logstash/conf.d/logstash.conf --debug',
    require    => Class['config::swarm'] 
    }

   swarm_run {'elasticsearch':
     ensure     => present,
     image      => 'elasticsearch:2.1.0',
     network    => 'swarm-private',
     volumes    => ['/etc/esdata:/usr/share/elasticsearch/data'],
     command    => 'elasticsearch -Des.network.host=0.0.0.0',
     log_driver => 'syslog',
     log_opt    => 'syslog-address=tcp://logstash-5000.service.consul:5000',
     depends    => 'logstash',
     require    => Class['config::swarm'] 
     }
   
   swarm_run {'kibana':
     ensure     => present,
     image      => 'kibana:4.3.0',
     network    => 'swarm-private',
     ports      => ['80:5601'],
     env        => ['ELASTICSEARCH_URL=http://elasticsearch:9200', 'reschedule:on-node-failure'],
     log_driver => 'syslog',
     log_opt    => 'syslog-address=tcp://logstash-5000.service.consul:5000',
     depends    => 'logstash',
     require    => Class['config::swarm'] 
     }
   }
}
  
