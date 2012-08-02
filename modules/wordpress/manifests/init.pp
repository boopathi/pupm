class wordpress {
	include addWordpressRepo
    include installWordpress
	include configureHttpdForWordpress
}

class addWordpressRepo {
	file { '/etc/yum.repos.d/wordpress.repo':
		source => 'puppet:///modules/wordpress/wordpress.repo'
	}
}	

class installWordpress {
    package { 'wordpress-custom':
        ensure => installed,
    }
}

class configureHttpdForWordpress {
	file { '/etc/httpd/conf.d/wordpress.conf':
		source => 'puppet:///modules/wordpress/wordpress.conf'
	}
	file { '/opt/wordpress/wp-config.php':
		source => 'puppet:///modules/wordpress/wp-config.php'
	}
}
Class["installWordpress"] -> Class["addWordpressRepo"]
Class["configureHttpdForWordpress"] -> Class["installWordpress"]
