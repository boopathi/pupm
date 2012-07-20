class puppet_server {
	include puppet_serverInstall
}
class puppet_serverInstall {
	package { "puppet-server":
		ensure=>installed
	}
}

