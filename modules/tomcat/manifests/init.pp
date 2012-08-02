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
