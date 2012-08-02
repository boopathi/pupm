class postfix {
  package { 'postfix':
    ensure => installed,
  }
  file { '/etc/postfix/main.cf':
    mode => 644,
    owner => root,
    group => root,
    source => 'puppet:///modules/postfix/main.cf',
    require=>Package['postfix'],
  }
  service { 'postfix' :
    ensure => running,
    enable=>true,
    hasstatus=>true,
    require=>[Package['postfix'], File['/etc/postfix/main.cf']],
  }
}
