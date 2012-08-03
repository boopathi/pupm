class mysql_slave {
	$root_passwd = 'root'
    $repl_passwd = 'slave'
    $repl_user = 'repl'
    $master = 'dbm.g1.foo'

    $conf = "/etc/my.cnf"

    package { mysql-server: ensure => installed }
    package { "mysql": ensure => installed }

    file { $conf :
        source => "puppet:///modules/mysql_master/my.cnf",
        require => Package[mysql-server],
    }

    service { "mysqld" :
        ensure => running,
        enable => true,
        hasstatus=>true,
        require => File[$conf],
    }
    exec { 'mysql_install_db':
          command => '/usr/bin/mysql_install_db',
          require => Package['mysql-server'],
    }   
    exec { "set_root_passwd" : 
      unless => "/usr/bin/mysqladmin -uroot -p$root_passwd status",
      require => Service["mysqld"],
      command => "/usr/bin/mysqladmin -u root password $root_passwd"
    }

    exec { "set_master" :
        require => Exec["set_root_passwd"],
        command => "/usr/bin/mysql -uroot -p$root_passwd -e \"CHANGE MASTER TO MASTER_HOST=$master, MASTER_USER=$repl_user, MASTER_PASSWORD=$repl_passwd\""
    }
    exec { "start_slave" :
        require => Exec["set_master"],
        command => "/usr/bin/mysql -uroot -p$root_passwd -e \"start slave\""
    }
}
