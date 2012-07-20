class tomcat {
	include tomcatInstall
}
class tomcatInstall {
	package { 'tomcat5':
		ensure=>present
	}
}
