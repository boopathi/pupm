class mysql_slave {
	$root_passwd = 'root'
    $repl_passwd = 'slave'
    $repl_user = 'repl'
    $repl_target = 'dbs.g1.foo'
    $repl_passwd = 'slave'

    $conf = "/etc/my.cnf"

    package { mysql-server: ensure => installed }
    package { "mysql": ensure => installed }

    file { $conf :
        source => "puppet:///modules/mysql_master/my.cnf",
        require => Package[$mysql-server]
    }

    service { "mysqld" :
        ensure => running,
        enable => true,
        require => File[$conf],
    }

    exec { "set_root_passwd" : 
      unless => "/usr/bin/mysqladmin -uroot -p$root_passwd status",
      require => Service["mysqld"],
      command => "/usr/bin/mysqladmin -u root password $root_passwd"
    }

    exec { "replication_user" :
		unless => "/usr/bin/mysqladmin -uwordpress -p$wordpress_passwd status",
        require => Exec["set_root_passwd"],
        command => "/usr/bin/mysql -uroot -p$root_passwd -e \"grant replication slave on *.* to '$repl_user'@'172.16.%' identified by '$repl_passwd'\""
    }
}
