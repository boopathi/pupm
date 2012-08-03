class postfix {
	package { 'postfix': ensure => installed }
	package { 'dovecot': ensure => installed }
	package { 'sendmail': ensure => absent }

	file { '/etc/postfix/main.cf':
		mode => 644,
		ownner => root,
		group => root,
		source => 'puppet:///modules/postfix/main.cf',
		require=>[Package['postfix'], Package['sendmail']],
  	}
	file { '/etc/dovecot.conf':
		mode => 644,
		ownner => root,
		group => root,
		source => 'puppet:///modules/postfix/dovecot.conf',
		require=>Package['dovecot'], Package['sendmail']],
  	}	
	service { 'postfix':
		ensure => running,
    		enable=>true,
    		hasstatus=>true,
    		require=>[Package['postfix'], Package['sendmail'], File['/etc/postfix/main.cf']],
  	}
	service { 'dovecot':
		ensure => running,
    		enable=>true,
    		hasstatus=>true,
    		require=>[Package['dovecot'], Package['sendmail'], File['/etc/dovecot.conf']],
	}
}
