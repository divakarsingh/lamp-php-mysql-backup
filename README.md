# PHP-MySQL backup script for LAMP server

This script takes backup of a LAMP server, taking the complete /home directory and all of the MYSQL databases.

## Brief
The script makes use of FTP and RSYNC protocols for transferring database and web backups respectively.
Script assumes that FTP and RSYNC are performed using same user, towards the same server.
The script backups databases (not files) on local directory also.

## System Requirements

Following must be installed: 

* sshpass
* rsync
* ftp
* gzip

## First usage

The rsync connection should be tested before using this script. It may ask for storing ssh fingerprints, when you setup the rsync for the first time.

## Configuration Parameters
Following paraneters need to be edited between parameters_start and parameters_end tags.

```
DB_USER: This should be a mysql user having access to all mysql fatabases. Usually this is root.
DB_PASS: Password of the above mysql user.
RSYNC_USER: Username for ftp/rsync
RSYNC_HOST: Host for ftp/rsync
RSYNC_PASS: Password for ftp/rsync
RSYNC_PATH: Backup directory on backup server, for ftp/rsync
LOCAL_DIR: Local directory where backups are stored. 
ALERT_EMAIL: Email id where you want to get notification of backup completion
WEB_ROOT: Web root directory where  php files are stored. This is usually "/home".
```

### Sample configuration:
```
DB_USER=root
DB_PASS=abc
RSYNC_USER=backup
RSYNC_HOST=127.0.0.1
RSYNC_PASS=abc
RSYNC_PATH=user1/backups
LOCAL_DIR=/root/backup
ALERT_EMAIL=example@example.com
WEB_ROOT=/home
```
## Usage
```
$sh lamp-backup.sh
```

## Disclaimer
You may want to take backup of the server before running the script for the first time. As of now this is pretty simple and no-nonsense script which just works.

## Support
For further support, you may create issue here, or contact me from https://www.qtriangle.in. I can also help if you need [eCommerce website development](https://www.qtriangle.in) or any other related services.
