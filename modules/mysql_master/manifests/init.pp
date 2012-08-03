class mysql {
  package { 'mysql-server': ensure=>installed }
  package { 'mysql': ensure=>installed }
}
class mysql::master inherits mysql {
  
}
class mysql::slave inherits mysql {

}
class mysql_master {
  $root_passwd = 'root'
  $wordpress_passwd = 'wordpress'
  $repl_user = 'repl'
  $repl_target = 'dbs.g1.foo'
  $repl_passwd = 'slave'

  $package = "mysql-server"
  $conf = "/etc/my.cnf"

  $create_grant_user_sql = "GRANT ALL PRIVILEGES ON wordpress.* TO 'wordpress'@'172.16.%' IDENTIFIED BY 'wordpress';"
  
  package { $package: ensure => installed }
  package { "mysql": ensure => installed }

  file { $conf :
    source => "puppet:///modules/mysql_master/my.cnf",
    require => Package[$package],
  }

  service { "mysqld" :
    ensure => running,
    hasstatus=>true,
    enable => true,
    require => File[$conf],
    subscribe => File[$conf],
  }
  exec { 'mysql_install_db':
    command => '/usr/bin/mysql_install_db',
    require => Package['mysql-server'],
  }
  exec { "set_root_passwd" : 
    unless => "/usr/bin/mysqladmin -uroot -p$root_passwd status",
    require => [ Service["mysqld"], Exec['mysql_install_db'] ],
    command => "/usr/bin/mysqladmin -u root password $root_passwd"
  }

  exec { "replication_user" :
    require => Exec["set_root_passwd"],
    command => "/usr/bin/mysql -uroot -p$root_passwd -e \"grant replication slave on *.* to '$repl_user'@$repl_target identified by '$repl_passwd'\""
  }
  
  exec { "create_wordpress_database":
    require => Exec["set_root_passwd"],
    command => "/usr/bin/mysql -uroot -p$root_passwd -e \"CREATE DATABASE IF NOT EXISTS wordpress\"",
  }
  
  exec { "create_wordpress_user":
    require => Exec["create_wordpress_database"],
    command => "/usr/bin/mysql -uroot -p$root_passwd -e \" $create_grant_user_sql \"",
  }
  
}
