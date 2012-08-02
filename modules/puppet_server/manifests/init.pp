class puppet_server {
  include puppet_serverInstall
  include bindInstall
  include bindConfigure
  include bindRunning
}
# Puppet server
class puppet_serverInstall {
	package { "puppet-server":
		ensure=>installed
	}
}

#Bind Configurations
class bindInstall {
  package { 'bind':
    ensure=>installed
  }
}
class bindConfigure {
  file { '/var/named/chroot/testing':
    mode=>644,
    owner=>root,
    group=>root,
    recurse=>true,
    source=>'puppet:///modules/puppet_server/bindvar'
  }
  file { '/var/named/chroot/etc/naaa.conf':
    mode=>644,
    owner=>root,
    group=>root,
    source=>'puppet:///modules/puppet_server/named.conf'
  }
}
class bindRunning {
  service { 'named':
    ensure=>running,
    hasstatus=>true,
    enable=>true
  }
}

Class['bindRunning'] -> Class['bindConfigure']
Class['bindConfigure'] -> Class['bindInstall']
