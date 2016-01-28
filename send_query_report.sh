#!/bin/bash
#

# 1. Install aws CLI
#
# Uses python "aws" command line tools.  pip install awscli usually works
# or apt-get / yum packages
#
# 2. Install percona-toolkit
#
# cd /usr/local/bin
# wget percona.com/get/pt-query-digest
# yum install perl-Time-HiRes
#

# 3. change recipient 
EMAIL="hullsean@gmail.com"

# 4. run via command line or cron
#
# send_query_report.sh myrds.aa7b1c4de111.us-east-1.rds.amazonaws.com 
#

# pass the rds instance name on the command line
AWS_INSTANCE=$1

# latest slowquery.log
SLOWLOG=/var/log/mysql-slow.log
#SLOWLOG=`/bin/ls -tr /var/log/mysql-slow*.log | /usr/bin/tail -1`

# fetch slow query log from rds box
# here I always grab the latest one.
#
/usr/local/bin/aws rds download-db-log-file-portion --db-instance-identifier $AWS_INSTANCE --output text --log-file-name slowquery/mysql-slowquery.log > $SLOWLOG

# mk-query-digest report output
SLOWREPORT="/tmp/reportoutput.txt"

# pt-query-digest location
# maybe I should just assume this is in the path
PTQD=/usr/local/bin/pt-query-digest

# perform analysis
$PTQD $SLOWLOG > $SLOWREPORT

# today's date
TODAY=`/bin/date +\%m/\%d/\%Y-\%H:\%S`
#YESTERDAY=`/bin/date  -d "1 day ago" +\%m/\%d/\%Y-\%H:\%S`

# report subject
SUBJECT="Slow Query Report -- $TODAY "




# send an email using /bin/mail
/bin/mail -s "$SUBJECT" "$EMAIL" < $SLOWREPORT
 
