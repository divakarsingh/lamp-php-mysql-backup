#!/bin/bash -x

#parameters_start
DB_USER=
DB_PASS=
RSYNC_USER=
RSYNC_HOST=
RSYNC_PASS=
RSYNC_PATH=
LOCAL_DIR=
ALERT_EMAIL=
WEB_ROOT=
#parameters_end

HOST=`hostname`

#Get a list of databases
mkdir -p $LOCAL_DIR/dbs/
databases=`mysql -e "SHOW DATABASES" -u$DB_USER -p$DB_PASS | tr -d "| " | grep -vE '(Database|information_schema|horde_groupware|roundcubemail|cube|mysql|rcdb|kloxo|popuser|vpopmail|cphulkd|eximstats|leechprotect|modsec|performance_schema|whmxfer)'`
/bin/rm -rf $LOCAL_DIR/dbs/*
mkdir -p $LOCAL_DIR/dbs/`date +%Y-%m-%d`

#Dump each database in turn
for db in $databases; do
  echo Backing up database $db ...
  mysqldump --opt --hex-blob --force -u$DB_USER -p$DB_PASS --databases  $db |  gzip -f > $LOCAL_DIR/dbs/`date +%Y-%m-%d`/db_$db.gz
  echo Done
done
echo "making tar ball.. "
tar -zcvf $LOCAL_DIR/dbs-`date +%Y-%m-%d`-fe.tgz $LOCAL_DIR/dbs/`date +%Y-%m-%d`/

ftp -inv $RSYNC_HOST <<END_SCRIPT
user $RSYNC_USER $RSYNC_PASS
lcd $LOCAL_DIR
cd $RSYNC_PATH
bi
ha
put dbs-`date +%Y-%m-%d`-fe.tgz

quit
END_SCRIPT
#exit 0

echo "DB backup complete for $HOST"
echo "starting rsync.."

/usr/bin/sshpass -p $RSYNC_PASS /usr/bin/rsync -avz $WEB_ROOT/*  --exclude 'admin'     --exclude 'apache'       --exclude 'bind'       --exclude 'djbdns'       --exclude 'httpd'       --exclude 'kloxo'       --exclude 'lighttpd'       --exclude 'lxadmin'       --exclude 'nginx'       --exclude 'nouser'       --exclude 'php-fpm'       --exclude 'phpini'       --exclude 'scan_log'       --exclude 'vpopmail'  $RSYNC_USER@$RSYNC_HOST:$RSYNC_PATH

echo "rsync complete.."

mail -s"DB and file backup complete on $HOST" $ALERT_EMAIL  < /dev/null
