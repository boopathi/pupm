class tomcat {
  package { 'tomcat5':
    ensure=>installed
  }
  service {'tomcat':
    ensure=>running,
    require=>Package['tomcat5'],
  }
}
