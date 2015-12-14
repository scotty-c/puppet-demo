class config::dns {
	
  package { 'bind':
    ensure => present
  } ->
  
  file { '/etc/named.conf':
    ensure  => present,
    content => template("config/named.conf.erb"),
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    require => Package['bind'],
  } ~>

  file { '/etc/named/consul.conf':
    ensure  => present,
    content => template("config/consul.conf.erb"),
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    require => Package['bind'],
  } ~>


  service { 'named':
    ensure  => running,
    enable  => true,
    require => File['/etc/named.conf'],
  } 
}