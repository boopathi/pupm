class puppet_server::cron{
    package { 'rsnapshot': 
        ensure => installed,
    }
    file { '/etc/cron.hourly/backup.sh':
        source=>'puppet:///modules/puppet_server/backup.sh',
        mode   => 755,
    }
}
