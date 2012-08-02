class mysql_master {
	$root_passwd = 'root'
	$wordpress_passwd = 'wordpress'
    $repl_user = 'repl'
    $repl_target = 'dbs.g1.foo'
    $repl_passwd = 'slave'

    $package = "mysql-server"
    $conf = "/etc/my.cnf"

    package { $package: ensure => installed }
    package { "mysql": ensure => installed }

    file { $conf :
        source => "puppet:///modules/mysql_master/my.cnf",
        require => Package[$package]
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
        command => "/usr/bin/mysql -uroot -p$root_passwd -e \"grant replication slave on *.* to '$repl_user'@$repl_target identified by '$repl_passwd'\""
    }
	
	exec { "create_wordpress_user_x":
		unless => "/usr/bin/mysqladmin -uwordpress -p$wordpress_passwd status",
		require => Exec["set_root_passwd"],
		command => "/usr/bin/mysql -uroot -p$root_passwd -e \"CREATE USER 'wordpress'@'x.g1.foo' IDENTIFIED BY 'wordpress'\"",
	}
	exec { "create_wordpress_user_y":
		unless => "/usr/bin/mysqladmin -uwordpress -p$wordpress_passwd status",
		require => Exec["set_root_passwd"],
		command => "/usr/bin/mysql -uroot -p$root_passwd -e \"CREATE USER 'wordpress'@'y.g1.foo' IDENTIFIED BY 'wordpress'\"",
	}
     exec { "create_wordpress_user_localhost":
        unless => "/usr/bin/mysqladmin -uwordpress -p$wordpress_passwd status",
        require => Exec["set_root_passwd"],
        command => "/usr/bin/mysql -uroot -p$root_passwd -e \"CREATE USER 'wordpress'@'localhost' IDENTIFIED BY 'wordpress'\"",
    }

	
	exec { "create_wordpress_database":
		require => Exec["set_root_passwd"],
		command => "/usr/bin/mysql -uroot -p$root_passwd -e \"CREATE DATABASE IF NOT EXISTS wordpress\"",
	}

    exec { "restart_mysqld" :
        require => Exec["replication_user"],
        command => '/sbin/service mysqld restart'
    }
}
