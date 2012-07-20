class etc_hosts {
	file { "/etc/hosts":
		mode=>644,
		owner=>root,
		group=>root,
		source=>'puppet:///modules/hosts/hosts"
	}
}
class hosts {
	host { 'ga': 
		ip=>'172.16.143.171'
	}
	
	host { 'gb': ip=>"172.16.143.172" }
	host { 'gc': ip=>"172.16.143.173" }
	host { 'gd': ip=>"172.16.143.174" }
	host { 'ge': ip=>"172.16.143.175" }
}
