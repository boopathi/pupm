class postfix {
	include postfixInstall
	include postfixConfigure
	include postfixStart
}

class postfixInstall {
  package { 'postfix':
      ensure => installed,
    }
}

class postfixConfigure {
  file { '/etc/postfix/main.cf':
      mode => 644,
      owner => root,
      group => root,
      source => 'puppet:///modules/postfix/main.cf',
    }
}

class postfixStart {
  service { 'postfix' :
      ensure => running,
    }
}

Class["postfixConfigure"] -> Class["postfixInstall"]
Class["postfixStart"] -> Class["postfixConfigure"]
