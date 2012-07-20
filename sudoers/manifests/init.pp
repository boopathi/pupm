class sudoers {
	file {"/etc/sudoers" :
		mode=>440,
		user=>root,
		group=>root,
		source=>'puppet:///modules/sudoers/sudoers'
	}
}

