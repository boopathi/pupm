class sudoers {
	package {"sudo":
		ensure=>latest
	}
	file {"/etc/sudoers" :
		mode=>440,
		user=>root,
		group=>root,
		source=>'puppet:///modules/sudoers/sudoers',
		require=>Package['sudo']
	}
}

