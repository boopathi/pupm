class php {
	include phpInstall
}

class phpInstall {
	package {"php":
		ensure => installed
	}
}


