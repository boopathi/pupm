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
  package { 'sample-app-g1':
    ensure=>installed,
    require=>File['/etc/yum.repos.d/wordpress.repo']
    }

  file { '/etc/yum.repos.d/wordpress.repo':
       source => 'puppet:///modules/wordpress/wordpress.repo',
       require=>Service['tomcat5']
       }

}

class tomcat::apache_conf {
  include apache
  file { '/etc/httpd/conf.d/tomcat.conf':
    mode=>644,
    owner=>root,
    group=>root,
    source=>'puppet:///modules/tomcat/tomcat.conf',
    require=>[ Package['httpd'], Service['httpd'] ]
  }
}
