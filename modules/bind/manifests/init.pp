class bind {
	include bindInstall
}
class bindInstall {
	package {"bind":
		ensure=>installed
	}
}

