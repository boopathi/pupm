class nginx {
  $repofile = "/etc/yum.repos.d/nginx.repo"
  $conf = "/etc/nginx/nginx.conf"

  $package = "nginx"

  file { $repofile:
    owner=>root,
    group=>root,
    mode=>644,
    source=>'puppet:///modules/nginx/nginx.repo',
  }
  
  package { $package:
    ensure=>installed,
    require=>File[$repofile],
  }

  file { $conf:
    owner=>root,
    group=>root,
    mode=>644,
    source=>'puppet:///modules/nginx/nginx.conf',
    require=>Package[$package],
    notify=>Service['nginx'],
  }
  service { 'nginx':
    ensure=>running,
    hasstatus=>true,
    enable=>true,
    require=>File[$conf],
  }
}
class nginx::php {
  $phpini = "/etc/php.d/php_nginx.ini"
  $cgienable = "cgi.fix_pathinfo=0"
  
  file { $phpini:
    mode=>644,
    owner=>root,
    group=>root,
    content=>$cgienable,
    require=>[ Package['php53'], Package['php53-common'] ],
    notify=>Service['httpd'],
  }
}
