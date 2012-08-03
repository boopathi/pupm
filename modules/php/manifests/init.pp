class php {
    include phpRemoveUnwanted
    include phpInstall
}

class phpRemoveUnwanted
{
    package {"php":
        ensure => absent;
    }
    package {"php-cli":
        ensure => absent;
    }
    package {"php-common":
        ensure => absent;
    }
    package {"php-ldap":
        ensure => absent;
    }
}

class phpInstall {
    package {"php53":
        ensure => installed
    }
    package {"php53-common":
        ensure => installed
    }
    package {"php53-mysql":
        ensure => installed,
        notify => Service["httpd"],
    }
}
