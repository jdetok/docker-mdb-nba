#!/bin/bash

DATE=$(date +"%Y%m%d_%H%M%S")

CONTAINER=mdb
MAXBKPS=5

NBA_DB=nba
NBA_DIR=/home/jdeto/dkr/mdb/bkp/${NBA_DB}
NBA_DUMP=${NBA_DIR}/${NBA_DB}_${DATE}.sql
NBA_LOG=${NBA_DIR}/${NBA_DB}_${DATE}.log

MYSQL_DB=mysql
MYSQL_DIR=/home/jdeto/dkr/mdb/bkp/${MYSQL_DB}
MYSQL_DUMP=${MYSQL_DIR}/${MYSQL_DB}_${DATE}.sql
MYSQL_LOG=${MYSQL_DIR}/${MYSQL_DB}_${DATE}.log

# rm oldest .sql and .log file from dir when number of files in dir > MAXBKPS
# called in dump()
function rm_old() {
	local dir=$1
	local log=$2

	nfiles=$(find $dir -type f | wc -l)
	echo "$nfiles files exist in dir after db backup --" | tee -a $log

 	if [ $nfiles -gt $MAXBKPS ]; then	
	 	echo "removing oldest .sql file..." | tee -a $log
		rmsql=$(ls -1t $dir/*.sql | tail -1)
 		rm $rmsql

		echo "removing oldest .log file..." | tee -a $log
		rmlog=$(ls -1t $dir/*.log | tail -1)
 		rm $rmlog

		
		nfiles_after=$(find $dir -type f | wc -l)
		echo "$nfiles_after files now exist in $dir" | tee -a $log
		echo "exiting after removing old .sql and .log files at $(date +"%T")" | tee -a $log
	else
 		echo "exiting without removing files $(date +"%T")..." | tee -a $log
	fi
}

# perform dump on specified database and check if old dumps/logs need deleted
function dump() {
	local db=$1
	local dir=$2
	local dump=$3
	local log=$4

	mkdir -p $dir
	echo "starting dump for $db at $(date +"%T")..." | tee -a $log
	docker exec $CONTAINER mariadb-dump $db > $dump
	echo "dump complete -> saved to $dump at $(date +"%T")" | tee -a $log

	echo "removing old .sql and .log files from $dir..." | tee -a $log
	rm_old $dir $log
}

# DUMP NBA DATABASE
dump $NBA_DB $NBA_DIR $NBA_DUMP $NBA_LOG

# DUMP MYSQL DATABASE (for users primarily)
dump $MYSQL_DB $MYSQL_DIR $MYSQL_DUMP $MYSQL_LOG
