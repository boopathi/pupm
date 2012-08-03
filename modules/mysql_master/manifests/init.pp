class mysql_master {
  $root_passwd = 'root'
  $wordpress_passwd = 'wordpress'
  $repl_user = 'repl'
  $repl_target = 'dbs.g1.foo'
  $repl_passwd = 'slave'

  $package = "mysql-server"
  $conf = "/etc/my.cnf"

  # $create_user_sql = "" #"CREATE USER 'wordpress'@'172.16.%' IDENTIFIED BY 'wordpress';"
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
  #  unless => "/usr/bin/mysqladmin -uwordpress -p$wordpress_passwd status",
    require => Exec["set_root_passwd"],
    command => "/usr/bin/mysql -uroot -p$root_passwd -e \"grant replication slave on *.* to '$repl_user'@$repl_target identified by '$repl_passwd'\""
  }
  
  # exec { "create_wordpress_user_y":
  #   unless => "/usr/bin/mysqladmin -uwordpress -p$wordpress_passwd status",
  #   require => Exec["set_root_passwd"],
  #   command => "/usr/bin/mysql -uroot -p$root_passwd -e \"CREATE USER 'wordpress'@'172.16.%' IDENTIFIED BY 'wordpress'\"",
  # }
  # exec { "create_wordpress_user_localhost":
  #   unless => "/usr/bin/mysqladmin -uwordpress -p$wordpress_passwd status",
  #   require => Exec["set_root_passwd"],
  #   command => "/usr/bin/mysql -uroot -p$root_passwd -e \"CREATE USER 'wordpress'@'localhost' IDENTIFIED BY 'wordpress'\"",
  # }
  
  exec { "create_wordpress_database":
    require => Exec["set_root_passwd"],
    command => "/usr/bin/mysql -uroot -p$root_passwd -e \"CREATE DATABASE IF NOT EXISTS wordpress\"",
  }
  
  exec { "create_wordpress_user":
  #  unless => "/usr/bin/mysqladmin -uwordpress -p$wordpress_passwd status",
    require => Exec["create_wordpress_database"],
    command => "/usr/bin/mysql -uroot -p$root_passwd -e \" $create_grant_user_sql \"",
  }
  
  # exec { "restart_mysqld" :
  #   require => Exec["replication_user"],
  #   command => '/sbin/service mysqld restart'
  # }
}
