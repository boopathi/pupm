class wordpress {
	include addWordpressRepo
    #include installWordpress
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

Class["installWordpress"] -> Class["addWordpressRepo"]
