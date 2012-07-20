class puppet_client {
	include puppet_clientInstall
	include puppet_clientConfigure
}
class puppet_clientInstall {
	package { "puppet":
		ensure=>installed
	}
}
class puppet_clientConfigure {
	files { "/etc/puppet/puppet.conf":
		mode=>644,
		owner=>root,
		group=>root,
		source=>'puppet:///modules/puppet_client/puppet.conf'
	}
}
class { "puppet_clientConfigure": require => Class["puppet_clientInstall"] }
