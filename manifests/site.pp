#node /^group1_2$/ {
class initial {
	include hosts
	include users
	include puppet_client
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
