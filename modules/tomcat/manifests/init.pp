class tomcat {
  package { 'tomcat5':
    ensure=>installed
  }
  service {'tomcat':
    ensure=>running,
    hasstatus=>true,
    enable=>true,
    require=>Package['tomcat5'],
  }
}
