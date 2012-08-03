class apache {

  $conf = "/etc/httpd/conf/httpd.conf"
  $package = "httpd"
  $vhosts = '/etc/httpd/conf.d/vhosts.conf'
  
  package { $package : ensure=>installed }

  service {'httpd':
    require=>[Package[$package], File[$conf]],
    subscribe=>File[$conf],
    ensure=>running,
    hasstatus=>true,
    enable=>true,
  }
  
  file { $conf:
    mode=>644,
    owner=>root,
    group=>root,
    require=>Package[$package],
    source=>'puppet:///modules/apache/httpd.conf',
  }
  
  define gen_vhosts (
    $hostname = "*",
    $portnum = "80",
    $ServerName,
    $DocumentRoot,
    $Location = "",
    $ProxyPass = ""
    ) {
    file { $vhosts:
      mode=>644,
      owner=>root,
      group=>root,
      require=>Package[$package],
      ensure=>file,
      content=>template(apache/vhosts.conf),
    } 
  }
  
}
