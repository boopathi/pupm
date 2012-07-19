class etc_hosts {
	file { "/etc/hosts":
		mode=>644,
		owner=>root,
		group=>root,
		source=>'puppet:///modules/hosts/hosts"
	}
}

