class apache {
  package { 'httpd':
      ensure => installed
    }

  file { '/etc/httpd/conf/httpd.conf':
      mode => 644,
      owner => root,
      group => root,
      source => 'puppet:///modules/apache/httpd.conf'
    }

  service { 'httpd' :
      ensure => running
    }

}
