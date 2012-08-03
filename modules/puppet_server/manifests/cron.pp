class puppet_server::cron{
    file { '/etc/cron.hourly/backup.sh':
        source=>'puppet:///modules/puppet_server/backup.sh'
    }
}
