# send_query_report
Fetch Amazon RDS or MySQL local slow query log, analyze &amp; email results to team

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

