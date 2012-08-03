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
    ['php53', 'php53-common', 'php53-mysql']: ensure=>installed;
    'php53-mysql': notify=>Service['httpd']
  }
}
