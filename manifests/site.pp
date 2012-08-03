#server1
node /^g1.foo$/ {
  include postfix
  include puppet_server
  include puppet_server::bind
}

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

#server 5
node /^dbs.g1.foo$/ {
  include mysql_slave
}
