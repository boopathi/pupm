define add_user ( $uid, $password="puppet_password" ) {

            $username = $title

            user { $username:
                    home    => "/home/$username",
                    shell   => "/bin/bash",
                    uid     => $uid,
		    password=> $password
            }

            group { $username:
                    gid     => $uid,
                    require => User[$username]
            }

            file { "/home/$username/":
                    ensure  => directory,
                    owner   => $username,
                    group   => $username,
                    mode    => 750,
                    require => [ User[$username], Group[$username] ]
            }
}

define usermod ( $uid, $groups ) {
	user { $username:
		ensure=>present,
		groups=>$groups
	}
}
