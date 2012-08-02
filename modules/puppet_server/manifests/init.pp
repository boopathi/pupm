class puppet_server {
  include puppet_serverInstall
  include bind
}
# Puppet server
class puppet_serverInstall {
	package { "puppet-server":
		ensure=>installed
	}
}

#Version 2.0 bind config
class bind {
  include bindInstall
  include bindConfigure
  include bindRunning
  Class['bindRunning'] -> Class['bindConfigure']
  Class['bindConfigure'] -> Class['bindInstall']
}

#New bind config
# class bind {
#   package {
#     'bind': ensure=>installed;
#     'bind-chroot': require=>Package['bind'];
#   }
#   class bindConfigure {
#     File {
#       mode=>644,
#       owner=>root,
#       group=>root,
#       notify=>Service['named'],
#       require=>Package['bind-chroot']
#     }
#     file { '/var/named/chroot//var/named':
#       recurse=>true,
#       source=>'puppet:///modules/puppet_server/bindvar'
#     }
#     file { '/var/named/chroot//etc/named.conf':
#       source=>'puppet:///modules/puppet_server/named.conf'
#     }
#   }
  
#   service{ 'named':
#     ensure=>running,
#     hasstatus=>true,
#     enable=>true,
#     require=>[ Package['bind-chroot'], Class['bindConfigure'] ]
#   }
# }


#Bind Configurations
class bindInstall {
  package { 'bind':
    ensure=>present
  }
  package {'bind-chroot':
    ensure=>installed,
    require=>Package['bind']
  }
}

class bindConfigure {
  File {
    mode=>644,
    owner=>root,
    group=>root,
    notify=>Service['named']
  }
  file { '/var/named/chroot//var/named':
    recurse=>true,
    source=>'puppet:///modules/puppet_server/bindvar'
  }
  file { '/var/named/chroot//etc/named.conf':
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

