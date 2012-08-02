# Class: mysql
#
#   This class installs mysql client software.
#
# Parameters:
#   [*client_package_name*]  - The name of the mysql client package.
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
#class mysql (
#  $package_name   = $mysql::params::client_package_name,
#  $package_ensure = 'present'
#) inherits mysql::params {
#
#  package { 'mysql_client':
#  name    => $package_name,
#   ensure  => $package_ensure,
#  }

#}

#class { 'mysql::server':
#  config_hash => { 'root_password' => 'foo' }
#}


$mysql_password = "centos"

class mysql::server {

  package { "mysql-server": ensure => installed }
  package { "mysql": ensure => installed }

  service { "mysqld":
    enable => true,
    ensure => running,
    require => Package["mysql-server"],
  }

  file { "/var/lib/mysql/my.cnf":
    owner => "mysql", group => "mysql",
    source => "puppet:///mysql/my.cnf",
    notify => Service["mysqld"],
    require => Package["mysql-server"],
  }

  file { "/etc/my.cnf":
    require => File["/var/lib/mysql/my.cnf"],
    ensure => "/var/lib/mysql/my.cnf",
  }

  exec { "set-mysql-password":
    unless => "mysqladmin -uroot -p$mysql_password status",
    path => ["/bin", "/usr/bin"],
    command => "mysqladmin -uroot password $mysql_password",
    require => Service["mysqld"],
  }
  exec { "set-as-master":
    command => "mysqladmin -uroot -p$mysql_password",
    command => "GRANT REPLICATION SLAVE ON *.* TO 'root'@'172.16.143.175'",
    command => "CREATE USER 'wordpress'@'dbm.g1.foo' IDENTIFIED BY 'wordpress'",
    command => "GRANT ALL PRIVILEDGES ON *.* TO 'wordpress'@'dbm.g1.foo'",
  }
}

