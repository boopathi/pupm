class puppet_server {
	include puppet_serverInstall
}
class puppet_serverInstall {
	package { "puppetmaster":
		ensure=>installed
	}
}

