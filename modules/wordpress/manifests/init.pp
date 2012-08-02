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
}

Class["installWordpress"] -> Class["addWordpressRepo"]
Class["configureHttpdForWordpress"] -> Class["installWordpress"]
