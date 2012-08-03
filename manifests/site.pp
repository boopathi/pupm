#node /^group1_2$/ {
# class initial {
# 	include hosts
# 	include users
# 	include puppet_client
# 	include wordpress
# }
# node 'group1_2.internal.directi.com' {
# 	include initial
# 	include tomcat
# 	include nginx
# 	include php
# 	include bind
# }

# node /^group1_3.internal.directi.com$/ {
# 	include initial
# 	include apache
# 	include tomcat
# 	include php
# 	include nagios
# }

#server2
node /^x.g1.foo$/ {
  include apache
  include tomcat
  include tomcat::apache_conf
  include php
  include wordpress
}

#server3
node /^y.g1.foo$/ {
  include nginx
  include php
  include fastcgi
}

#server4
node /^dbm.g1.foo$/ {
  include mysql_master
}

#server1
node /^g1.foo$/ {
  include puppet_server
  include puppet_server::bind
}

node /^dbs.g1.foo$/ {
  include mysql_slave
}
