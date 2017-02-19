# php-mysql-backup
This script takes backup of a LAMP server, taking home directory files and all of the MYSQL databases.
The script makes use of FTP and RSYNC protocols for transferring database and web backups respectively.
Script assumes that FTP and RSYNC are performed using same user, towards the same server.
The script backups databases (not files) on local directory also.

# configuration parameters
Following paraneters need to be edited between parameters_start and parameters_end tags.
DB_USER: This should be a mysql user having access to all mysql fatabases. Usually this is root.
DB_PASS: Password of the above mysql user.
RSYNC_USER: username for ftp/rsync
RSYNC_HOST: host for ftp/rsync
RSYNC_PASS: password for ftp/rsync
RSYNC_PATH: backup directory on backup server, for ftp/rsync
LOCAL_DIR: Local directory where backups are stored. 
ALERT_EMAIL=pr@qtriangle.in
WEB_ROOT: web root directory where  php files are stored. This is usually "/home".

# usage
$sh backup.sh
