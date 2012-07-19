class apache {
	include apacheInstall
	include apacheConfig
	include apacheStart
	class { "apacheConfig": require => Class["apacheInstall"] }
	class { "apacheStart": require => Class["apacheConfig"] }
}
class apacheInstall {
	package { 'httpd':
		ensure => installed
	}
}
class apacheConfig {
	file { '/etc/httpd/conf/httpd.conf':
		mode=>644,
		owner=>root,
		group=>root,
		source=>'puppet:///modules/apache/httpd.conf'
	}
}
class apacheStart {
	service { 'httpd':
		ensure=>running
	}
}

