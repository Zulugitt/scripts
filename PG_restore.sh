#!/bin/bash
D=`date +%d`
m=`date +%m`    # month
Y=`date +%Y`    #
I=`date +%H`    #hour
M=`date +%M`    #minute



BACKUP_DIR="/var/pg_backup/"

BaseUpload="Restore_test$1_$D$m$Y$I"

#REPORT=`cat /tmp/bak.txt`
REPORT="start"

DUMP=`find . -type f -name "$1" -print | sed 's/\.gz//g' | sed 's/\.\///g'`
DUMP_base=`find . -type f -name "$1" -print | sed 's/\.gz//g' | sed 's/\.\///g' | sed 's/\.sql//g'`

#echo $DUMP $DUMP_base

psql -c "DROP DATABASE IF EXISTS $DUMP_base WITH (FORCE);"
sleep 3
psql -c "CREATE DATABASE $DUMP_base ;"
sleep 3
gzip -d  $1
#psql --dbname $DUMP_base -f $DUMP





