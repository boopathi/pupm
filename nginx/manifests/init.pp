class nginx {
	include nginxInstall
	include nginxConfigure
	include nginxStart
	}
class nginxInstall {
  package { 'nginx':
      ensure => installed
    }

class nginxConfigure {
  file { '/etc/nginx/nginx.conf':
      mode => 644,
      owner => root,
      group => root,
      source => 'puppet:///modules/nginx/httpd.conf'
    }
}
class nginxStart {
  service { 'nginx' :
      ensure => running
    }
}
class { "nginxConfigure" : require=>Class["nginxInstall"] }
	class { "nginxStart" : require=>Class["nginxConfigure"] }

