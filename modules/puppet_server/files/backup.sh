#!/bin/bash

mkdir /mysql
for i in `mysql -uroot -proot -h 172.16.143.174 -Bse 'show databases'`; do mysqldump -uroot -proot -h 172.16.143.174 $i > /mysql/$i ; done
rsnapshot hourly
rm -rf /mysql
