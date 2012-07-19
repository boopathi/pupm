class tomcat {
	include tomcatInstall
}
class tomcatInstall {
	package { 'tomcat5':
		ensure=>present
	}
}
class tomcatDependencies {
	package { 'java':
		ensure=>present
	}
}

class { "tomcatInstall": require => Class["tomcatDependencies"] }

