class cluster {
  $repofile = '/etc/yum.repos.d/pacemaker.repo'
  $haconf = '/etc/ha.d/ha.cf'
  $authkeys = '/etc/ha.d/authkeys'
  $hosts = '/etc/hosts'
  
  #one
  file {
    $repofile:
      source => 'puppet:///modules/cluster/pacemaker.repo';
    $hosts:
      source => 'puppet:///modules/cluster/hosts';
  }

  #install required packages
  package {
    ['pacemaker', 'corosync', 'heartbeat']:
      ensure=>installed,
      require=> [ File[$repofile], File[$hosts] ],
  }

  #copy authkeys and ha.cf
  file {
    $haconf :
      require=>[ Package['pacemaker'], Package['corosync'], Package['heartbeat']],
      source=>'puppet:///modules/cluster/ha.cf' ;
    $authkeys :
      source=>'puppet:///modules/cluster/authkeys',
      require=>[ Package['pacemaker'], Package['corosync'], Package['heartbeat'] ],
      mode=>600,
      owner=>root,
      group=>root
  }

  #disable selinux
  exec { 'disable_selinux':
    command => '/bin/echo 0 > /selinux/enforce'
  }

  #start the service
  service { 'heartbeat':
    ensure=>running,
    require=> Exec['disable_selinux'],
  }
  
}

#class cluster::apache extends cluster {
#  
#}
