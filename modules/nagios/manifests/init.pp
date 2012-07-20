import "apache"
class nagios {
	include apache
	include nagiosInstall
}
class nagiosInstall {
	package {"nagios":
		ensure=>installed
	}
}
class { "nagios": require => Class["apache"] }

	
