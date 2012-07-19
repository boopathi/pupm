class nginx {
  package { 'nginx':
      ensure => installed
    }

  file { '/etc/nginx/nginx.conf':
      mode => 644,
      owner => root,
      group => root,
      source => 'puppet:///modules/nginx/httpd.conf'
    }

  service { 'nginx' :
      ensure => running
    }

}
