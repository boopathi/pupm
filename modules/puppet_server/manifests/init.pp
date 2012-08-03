# Puppet server

import cron.pp

class puppet_server {
  package { "puppet-server":
    ensure=>installed
  }
  service { 'puppetmaster':
    ensure=>running,
    require=>Package['puppet-server'],
  }
}

#New bind config
class puppet_server::bind {
  package {
    'bind': ensure=>installed;
    'bind-chroot': require=>Package['bind'];
  }

  File {
    mode=>644,
    owner=>root,
    group=>root,
    notify=>Service['named'],
    require=>Package['bind-chroot']
  }
  file { '/var/named/chroot//var/named':
    recurse=>true,
    source=>'puppet:///modules/puppet_server/bindvar'
  }
  file { '/var/named/chroot//etc/named.conf':
    source=>'puppet:///modules/puppet_server/named.conf'
  }
  
  service{ 'named':
    ensure=>running,
    hasstatus=>true,
    enable=>true,
    require=>[ Package['bind-chroot'], File['/var/named/chroot//etc/named.conf'] ]
  }
}
