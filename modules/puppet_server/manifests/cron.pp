file { '/etc/cron.hourly':
    source=>'puppet:///modules/puppet_server/backup.sh'
}
