#node /^group1_2$/ {
class initial {
	include hosts
	include users
	include puppet_client
	include wordpress
}
node 'group1_2.internal.directi.com' {
	include initial
	include tomcat
	include nginx
	include php
	include bind
}

node /^group1_3.internal.directi.com$/ {
	include initial
	include apache
	include tomcat
	include php
	include nagios
}


node 'dbm.g1.foo' {
	include mysql
}

node 'g1.foo' {
  include puppet_server
}
