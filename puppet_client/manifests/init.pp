class puppet_client {
	include puppet_clientInstall
	include puppet_clientConfigure
	include puppet_clientRunning
}
class puppet_clientInstall {
	package { "puppet":
		ensure=>installed
	}
}
class puppet_clientConfigure {
	file { "/etc/puppet/puppet.conf":
		mode=>644,
		owner=>root,
		group=>root,
		source=>'puppet:///modules/puppet_client/puppet.conf'
	}
}
class puppet_clientRunning {
	service { 'puppet':
		ensure=>running,
		hasstatus=>true,
		enable=>true,
	}
}
Class["puppet_clientConfigure"] -> Class["puppet_clientInstall"]
Class["puppet_clientRunning"] -> Class["puppet_clientConfigure"]

