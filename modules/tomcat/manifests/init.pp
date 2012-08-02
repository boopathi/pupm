class tomcat {
  package { 'tomcat5':
    ensure=>installed
  }
  service {'tomcat5':
    ensure=>running,
    hasstatus=>true,
    enable=>true,
    require=>Package['tomcat5'],
  }
}

class tomcat::apache_conf {
  file { '/etc/httpd/conf.d/tomcat.conf':
    mode=>644,
    owner=>root,
    group=>root,
    source=>'puppet:///modules/tomcat/tomcat.conf',
    require=>[ Package['httpd'], Service['httpd'] ]
  }
}
