class wordpress {
	include addWordpressRepo
	}
class addWordpressRepo {
	file { '/etc/yum.repos.d/wordpress.repo':
		source => 'puppet:///modules/wordpress/wordpress.repo'
	}

	
