class php {
    include phpRemoveUnwanted
    include phpInstall
}

class phpRemoveUnwanted
{
  package { ['php', 'php-cli', 'php-common','php-ldap']: ensure=>absent }
}

class phpInstall {
  package {
    ['php53', 'php53-common']: ensure=>installed
  }
  if defined( Service['httpd'] ) {
    package { 'php53-mysql': ensure=>installed, notify=>Service['httpd'] }
    } elsif defined ( Service['nginx'] ) {
    package { 'php53-mysql': ensure=>installed, notify=>Service['nginx'] }
    } else {
    package { 'php53-mysql': ensure=>installed }
    }
}                   
