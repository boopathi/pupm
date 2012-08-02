class apache {
  package {'httpd':
    ensure=>installed
  }
  file { '/etc/httpd/conf/httpd.conf':
    mode=>644,
    owner=>root,
    group=>root,
    source=>'puppet:///modules/apache/httpd.conf',
    require=>Package['httpd']
  }
  service {'httpd':
    require=>[Package['httpd'], File['/etc/httpd/conf/httpd.conf']],
    ensure=>running,
    hasstatus=>true,
    enable=>true
  }
}
#old
# class apache {
# 	include apacheInstall
# 	include apacheConfig
# 	include apacheStart
# 	}
# class apacheInstall {
# 	package { 'httpd':
# 		ensure => installed
# 	}
# }
# class apacheConfig {
# 	file { '/etc/httpd/conf/httpd.conf':
# 		mode=>644,
# 		owner=>root,
# 		group=>root,
# 		source=>'puppet:///modules/apache/httpd.conf'
# 	}
# }
# class apacheStart {
# 	service { 'httpd':
# 		ensure=>running
# 	}
# }
# class { "apacheConfig": require => Class["apacheInstall"] }
# 	class { "apacheStart": require => Class["apacheConfig"] }

