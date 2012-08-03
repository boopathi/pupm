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
    require=>File[$conf],
  }
}
